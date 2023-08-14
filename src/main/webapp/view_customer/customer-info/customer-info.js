
const passwordCheckSection = document.getElementById('passwordCheck');
const updateInfoSection = document.getElementById('updateInfo');
const passwordInput = document.getElementById('passwordInput');
const checkPasswordButton = document.getElementById('checkPasswordButton');
const updateForm = document.getElementById('updateForm');

// 비밀번호 입력 후 일치하는지 확인하는 함수
checkPasswordButton.addEventListener('click', () => {
    const password = '1234'; // 실제 비밀번호로 변경하세요

    if (passwordInput.value === password) {
        passwordCheckSection.style.display = 'none';
        updateInfoSection.style.display = 'block';
    } else {
        alert('비밀번호가 일치하지 않습니다.');
    }
});

updateForm.addEventListener('submit', (event) => {
    event.preventDefault();
    // 정보 수정 로직을 여기에 추가하세요
    alert('정보가 수정되었습니다.');
});

// alert 띄우기
const myLink = document.getElementById('button');

myLink.addEventListener('click', (event) => {
    event.preventDefault();
    alert('정보를 수정하시겠습니까?');
});