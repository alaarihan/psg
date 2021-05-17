---
to: <%= options.dir %>/roleSchema/index.ts
---

const { dmmf } = require('@prisma/client')
import { GraphQLSchema } from 'graphql'
import {
  FilterInputObjectFields,
  FilterObjectFields,
  FilterRootFields,
  FilterTypes,
  PruneSchema,
  TransformEnumValues,
  applySchemaTransforms,
} from 'graphql-tools'
import { camelize } from './helpers'

export function getUserRoleSchema(schema: GraphQLSchema, perms) {
  const schemaFilters = getRoleSchemaTransformations(perms)
  const modSchema = applySchemaTransforms(schema, {
    schema,
    transforms: [
      new FilterTypes((type) => {
        return (
          !(
            type.constructor.name === 'GraphQLObjectType' &&
            schemaFilters.types.includes(type.name)
          ) &&
          !(
            type.constructor.name === 'GraphQLInputObjectType' &&
            schemaFilters.inputs.includes(type.name)
          )
        )
      }),
      new FilterRootFields((operationName, fieldName, fieldConfig) => {
        return !schemaFilters.rootFields.includes(fieldName)
      }),
      new FilterObjectFields((typeName, fieldName, fieldConfig) => {
        return !schemaFilters.objectFields.some(
          (item) => item.model === typeName && item.fields.includes(fieldName),
        )
      }),
      new FilterInputObjectFields((typeName, fieldName, inputFieldConfig) => {
        return !schemaFilters.inputFields.some(
          (item) =>
            item.inputs.includes(typeName) && item.fields.includes(fieldName),
        )
      }),
      new TransformEnumValues((typeName, enumValue, enumValueConfig) => {
        let newEnumValue = undefined
        const isFilteredValue = schemaFilters.objectFields.some(
          (item) =>
            `${item.model}ScalarFieldEnum` === typeName &&
            item.fields.includes(enumValue),
        )

        if (isFilteredValue) {
          newEnumValue = null
        }
        return newEnumValue
      }),
      new PruneSchema(),
    ],
  })
  return modSchema
}
export type SchemaTransformations = {
  types?: String[]
  inputs?: String[]
  rootFields?: String[]
  objectFields?: ModelFields[]
  inputFields?: InputsFields[]
}

export class PermTypesModels {
  read: String[]
  create: String[]
  update: String[]
  delete: String[]
}

export type ModelFieldsByPermType = {
  read: ModelFields[]
  create: ModelFields[]
  update: ModelFields[]
  delete: ModelFields[]
}

export type ModelFields = {
  model: String
  fields: String[]
}

export type InputsFields = {
  inputs: String[]
  fields: String[]
}

function getRoleSchemaTransformations(perms): SchemaTransformations {
  const transformations: SchemaTransformations = {
    types: [],
    rootFields: [],
    inputs: [],
    objectFields: [],
    inputFields: [],
  }
  try {
    const filteredModels = getFilteredModels(perms)
    transformations.types = transformations.types.concat(filteredModels)

    const filteredRootFields = [
      ...getFilteredRootFieldsFromModels(filteredModels),
      ...getFilteredRootFieldsFromPerms(perms, filteredModels),
    ]
    transformations.rootFields = transformations.rootFields.concat(
      filteredRootFields,
    )

    const filteredInputs = [
      ...getFilteredInputsFromModels(filteredModels),
      ...getFilteredInputsFromPerms(perms),
    ]
    transformations.inputs = transformations.inputs.concat(filteredInputs)

    const FilteredModelsFields = getFilteredModelsFields(perms)
    transformations.objectFields = transformations.objectFields.concat(
      FilteredModelsFields.read,
    )

    const filteredInputsFileds = getFilteredInputsFileds(FilteredModelsFields)
    transformations.inputFields = transformations.inputFields.concat(
      filteredInputsFileds,
    )
  } catch (err) {
    console.log(err)
  }
  return transformations
}

function getFilteredModels(perms): String[] {
  if (!perms) perms = []
  const allowedModels: String[] = perms.map((item) => item.model)
  const filteredModels: String[] = dmmf.datamodel.models
    .filter((model) => !allowedModels.includes(model.name))
    .map((item) => item.name)
  return filteredModels
}

// Just the rest of the fields that haven't removed when removing the type
function getFilteredRootFieldsFromModels(filteredModels): String[] {
  let filteredRootFields: String[] = []
  dmmf.mappings.modelOperations
    .filter((item) => filteredModels.includes(item.model))
    .forEach((item) => {
      filteredRootFields = filteredRootFields.concat([
        `${item.plural}Count`,
        item.createMany,
        item.deleteMany,
        item.updateMany,
      ])
    })
  return filteredRootFields
}

function getFilteredRootFieldsFromPerms(perms, filteredModels): String[] {
  const modelsPerms = getFilteredModelsByPermType(perms)
  let filteredRootFields = []

  filteredRootFields = [
    ...getModelsFilteredFieldsByPermType(
      modelsPerms.read,
      'READ',
      filteredModels,
    ),
    ...getModelsFilteredFieldsByPermType(
      modelsPerms.create,
      'CREATE',
      filteredModels,
    ),
    ...getModelsFilteredFieldsByPermType(
      modelsPerms.update,
      'UPDATE',
      filteredModels,
    ),
    ...getModelsFilteredFieldsByPermType(
      modelsPerms.delete,
      'DELETE',
      filteredModels,
    ),
  ]
  return filteredRootFields
}

function getFilteredModelsFields(perms): ModelFieldsByPermType {
  const allowedModelsPerms = getAllowedModelsPerms(perms)
  const dataModels = dmmf.datamodel.models
  let filteredModelsFields: ModelFieldsByPermType = {
    read: [],
    create: [],
    update: [],
    delete: [],
  }
  for (const type in allowedModelsPerms) {
    dataModels.forEach((model) => {
      const modelFields = allowedModelsPerms[type].find(
        (item) => item.model === model.name,
      )
      if (modelFields) {
        const modelFilteredFields: String[] = model.fields
          .filter((field) => !modelFields.fields.includes(field.name))
          .map((item) => item.name)
        filteredModelsFields[type] = filteredModelsFields[type].concat({
          model: model.name,
          fields: modelFilteredFields,
        })
      }
    })
  }
  return filteredModelsFields
}

function getFilteredInputsFileds(modelsFields: ModelFieldsByPermType) {
  const inputsFields = []
  for (const type in modelsFields) {
    modelsFields[type].forEach((model) => {
      if (type === 'read') {
        inputsFields.push({
          inputs: [
            `${model.model}WhereInput`,
            `${model.model}OrderByInput`,
            `${model.model}ScalarWhereInput`,
          ],
          fields: model.fields,
        })
      } else if (type === 'create') {
        const nestedInputs = dmmf.schema.inputObjectTypes.prisma
          .filter((item) =>
            [
              `${model.model}CreateWithout`,
              `${model.model}UncheckedCreateWithout`,
            ].some((someItem) => item.name.startsWith(someItem)),
          )
          .map((item) => item.name)
        inputsFields.push({
          inputs: [...nestedInputs, `${model.model}CreateInput`],
          fields: model.fields,
        })
      } else if (type === 'update') {
        const nestedInputs = dmmf.schema.inputObjectTypes.prisma
          .filter((item) =>
            [
              `${model.model}UpdateWithout`,
              `${model.model}UncheckedUpdateWithout`,
              `${model.model}UpdateOneRequired`,
            ].some((someItem) => item.name.startsWith(someItem)),
          )
          .map((item) => item.name)
        inputsFields.push({
          inputs: [...nestedInputs, `${model.model}UpdateInput`],
          fields: model.fields,
        })
      }
    })
  }
  dmmf.datamodel.models.forEach((model) => {
    if (
      !modelsFields.delete.some((someItem) => model.name === someItem.model)
    ) {
      const inputs = dmmf.schema.inputObjectTypes.prisma
        .filter((item) =>
          [
            `${model.name}UpdateManyWithout`,
            `${model.name}UpdateOneWithout`,
          ].some((someItem) => item.name.startsWith(someItem)),
        )
        .map((item) => item.name)
      inputsFields.push({
        inputs: inputs,
        fields: ['delete', 'deleteMany'],
      })
    }
  })
  return inputsFields
}

function getFilteredInputsFromModels(filteredModels: String[]): String[] {
  const filteredInputs: String[] = []
  filteredModels.forEach((type) => {
    dmmf.schema.inputObjectTypes.prisma
      .filter(
        (item) =>
          [
            `${type}UpdateMany`,
            `${type}UpdateOne`,
            `${type}CreateNestedMany`,
            `${type}CreateNestedOne`,
          ].some((someItem) => item.name.startsWith(someItem)) ||
          [
            `${type}WhereInput`,
            `${type}WhereUniqueInput`,
            `${type}OrderByInput`,
            `${type}ListRelationFilter`,
          ].includes(item.name),
      )
      .forEach((item) => {
        filteredInputs.push(item.name)
      })
  })
  return filteredInputs
}

function getFilteredInputsFromPerms(perms): String[] {
  const modelsPerms = getFilteredModelsByPermType(perms)
  let filteredInputs = []
  for (const type in modelsPerms) {
    dmmf.datamodel.models.forEach((model) => {
      if (modelsPerms[type].includes(model.name)) {
        if (type === 'create') {
          const inputs = dmmf.schema.inputObjectTypes.prisma
            .filter((item) =>
              [
                `${model.name}CreateWithout`,
                `${model.name}UncheckedCreateWithout`,
                `${model.name}CreateMany`,
                `${model.name}CreateOrConnectWithout`,
                `${model.name}UpsertWithWhere`,
                `${model.name}UpsertWithout`,
              ].some((someItem) => item.name.startsWith(someItem)),
            )
            .map((item) => item.name)
          filteredInputs = filteredInputs.concat(inputs)
        } else if (type === 'update') {
          const inputs = dmmf.schema.inputObjectTypes.prisma
            .filter((item) =>
              [
                `${model.name}UncheckedUpdateWithout`,
                `${model.name}UpdateWithWhere`,
                `${model.name}UpdateManyWithWhere`,
                `${model.name}UpsertWithWhere`,
                `${model.name}UpsertWithout`,
              ].some((someItem) => item.name.startsWith(someItem)),
            )
            .map((item) => item.name)
          filteredInputs = filteredInputs.concat(inputs)
        }
      }
    })
  }
  return filteredInputs
}

function getAllowedModelsPermByType(perms, type): ModelFields[] {
  const allowedPerm = perms
    .filter((item) => item.type === type)
    .map((perm) => {
      let fields = perm.def?.columns || []
      const setFields = perm.def?.set || {}
      fields = fields.filter(
        (column) => !Object.keys(setFields).includes(column),
      )
      return {
        model: perm.model,
        fields,
      }
    })
  return allowedPerm
}

function getAllowedModelsPerms(perms): ModelFieldsByPermType {
  return {
    read: getAllowedModelsPermByType(perms, 'READ'),
    create: getAllowedModelsPermByType(perms, 'CREATE'),
    update: getAllowedModelsPermByType(perms, 'UPDATE'),
    delete: getAllowedModelsPermByType(perms, 'DELETE'),
  }
}

function getFilteredModelsByPermType(perms): PermTypesModels {
  const allowedModelsPerms = getAllowedModelsPerms(perms)
  const dataModels = dmmf.datamodel.models
  const filteredModelsPerms = new PermTypesModels()
  for (const type in allowedModelsPerms) {
    filteredModelsPerms[type] = dataModels
      .filter(
        (model) =>
          !allowedModelsPerms[type].some((item) => item.model === model.name),
      )
      .map((item) => item.name)
  }
  return filteredModelsPerms
}

function getModelsFilteredFieldsByPermType(
  models,
  type,
  filteredModels,
): String[] {
  let filteredFields: String[] = []

  dmmf.mappings.modelOperations
    .filter(
      (op) =>
        !filteredModels.includes(op.model) &&
        models.some((item) => item === op.model),
    )
    .forEach((item) => {
      if (type === 'READ') {
        filteredFields = filteredFields.concat([
          camelize(item.model),
          item.plural,
          `${item.plural}Count`,
        ])
      } else if (type === 'CREATE') {
        filteredFields = filteredFields.concat([
          `create${item.model}`,
          `upsert${item.model}`,
          item.createMany,
        ])
      } else if (type === 'UPDATE') {
        filteredFields = filteredFields.concat([
          `update${item.model}`,
          `upsert${item.model}`,
          item.updateMany,
        ])
      } else if (type === 'DELETE') {
        filteredFields = filteredFields.concat([
          `delete${item.model}`,
          item.deleteMany,
        ])
      }
    })
  return filteredFields
}
