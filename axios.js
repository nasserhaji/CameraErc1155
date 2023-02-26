const axios = require('axios');

axios.get('https://example.com/api/data', {
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer xxxxxx'
  },
  params: {
    'param1': 'value1',
    'param2': 'value2'
  }
})
.then(response => {
  console.log(response.data);
})
.catch(error => {
  console.error(error);
});
