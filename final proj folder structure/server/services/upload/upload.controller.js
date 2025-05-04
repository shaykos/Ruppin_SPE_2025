
export async function singleFileToStorage(req, res) {
  console.log('file --> ', req.file);
  res.end();
}

export async function multipleFilesToStorage(req, res) {
  console.log('file --> ', req.files);
  res.end();
}

