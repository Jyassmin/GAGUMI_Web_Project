// alert메세지 띄우기
const myLink = document.getElementById('add-button');

myLink.addEventListener('click', (event) => {
    event.preventDefault();
    alert('상품을 수정하시겠습니까?');
});

