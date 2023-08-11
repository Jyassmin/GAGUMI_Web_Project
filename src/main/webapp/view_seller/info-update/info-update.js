
// alert 띄우기
const myLink = document.getElementById('add-button');

myLink.addEventListener('click', (event) => {
    event.preventDefault();
    alert('정보를 수정하시겠습니까?');
});