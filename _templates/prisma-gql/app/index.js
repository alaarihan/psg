module.exports = {
  params: ({ args }) => {
   if(!args.name){
     args.name = 'new-psg-app'
   }
    return args
  },
}
