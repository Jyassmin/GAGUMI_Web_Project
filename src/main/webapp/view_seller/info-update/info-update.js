
const passwordCheckSection = document.getElementById('passwordCheck');
const updateInfoSection = document.getElementById('updateInfo');
const passwordInput = document.getElementById('passwordInput');
const checkPasswordButton = document.getElementById('checkPasswordButton');
const updateForm = document.getElementById('updateForm');
const originalPassword = document.getElementById('current_pw'); // 실제 비밀번호로 변경하세요

// 비밀번호 입력 후 일치하는지 확인하는 함수
checkPasswordButton.addEventListener('click', () => {
    const password = originalPassword.value;

    if (passwordInput.value === password) {
        passwordCheckSection.style.display = 'none';
        updateInfoSection.style.display = 'block';
    } else {
        alert('비밀번호가 일치하지 않습니다.');
    }
});

//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function userDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('user_postcode').value = data.zonecode;
            document.getElementById("user_roadAddress").value = roadAddr;
            document.getElementById("user_jibunAddress").value = data.jibunAddress;

            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("user_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("user_extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}

// 글자 크기 자동으로 맞춰주는 스크립트
function changeFontSize(inputValue) {
    const inputElement1 = document.getElementById("user_roadAddress");
    const inputElement2 = document.getElementById("user_jibunAddress");
    const inputElement3 = document.getElementById("user_detailAddress");
    const inputElement4 = document.getElementById("user_extraAddress");
    const maxLength = 10; // 글자 크기를 최대로 할 글자 수

    // 글자 크기 계산 및 적용
    const fontSize = 13 - (Math.min(inputValue.length / maxLength, 1)) * 10;
    inputElement1.style.fontSize = fontSize + "px";
    inputElement2.style.fontSize = fontSize + "px";
    inputElement3.style.fontSize = fontSize + "px";
    inputElement4.style.fontSize = fontSize + "px";
}

// 비밀번호 확인 체크 스크립트
const passwordField = document.getElementById('modify_pw');
const confirmPasswordField = document.getElementById('pw_check');
const passwordError = document.getElementById('passwordError');

function validatePassword() {
    if (passwordField.value !== confirmPasswordField.value) {
        passwordError.textContent = '비밀번호가 일치하지 않습니다.';
        return false;
    } else {
        passwordError.textContent = '';
        return true;
    }
}

confirmPasswordField.addEventListener('keyup', validatePassword);
document.getElementById('updateForm').addEventListener('submit', function(event) {
    if (!validatePassword()) {
        event.preventDefault(); // 폼 제출 방지
    }
});

// <!-- 비밀번호 변경하기 버튼을 누를 때 비밀번호 입력란을 보여주는 JavaScript 함수 -->
    function togglePasswordChangeFields() {
        var changePasswordButton = document.getElementById("changePasswordButton");
        var currentPW = document.getElementById("current_pw");
        var modifyPassword = document.getElementById("modifyPassword");
        var modifyPasswordCheck = document.getElementById("modifyPasswordCheck");
        var modifyPwInput = document.getElementById("modify_pw");
        var modifyPwCheckInput = document.getElementById("pw_check");
        modifyPwInput.value = currentPW.value;
        modifyPwCheckInput.value = currentPW.value;
        if (modifyPassword.style.display === "none") {
        // 비밀번호 변경하기 시작
        modifyPassword.style.display = "block";
        modifyPasswordCheck.style.display = "block";
            modifyPwInput.value = '';
            modifyPwCheckInput.value = '';
        changePasswordButton.value = "변경 취소";
        validatePassword();
    } else {
        // 비밀번호 변경 취소
        modifyPassword.style.display = "none";
        modifyPasswordCheck.style.display = "none";
        modifyPwInput.value = currentPW.value;
        modifyPwCheckInput.value = currentPW.value;
        changePasswordButton.value = "비밀번호 변경하기";
        validatePassword();
    }
}
