let g:ale_linters = {
  \'haskell': ['hlint'],
  \}
let g:lightline = {
  \'active': {
  \  'left': [
  \    ['mode', 'paste'],
  \    ['readonly', 'filename', 'modified', 'ale'],
  \          ]
  \          },
  \'component_function': {
  \  'ale': 'ALEGetStatusLine'
  \}
  \}

