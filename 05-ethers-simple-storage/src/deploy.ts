const main = async () => {}

main()
  .then(() => {
    process.exit(0)
  })
  .catch((error: any) => {
    console.log(error)
    process.exit(1)
  })
