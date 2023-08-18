const selectCustomer = document.getElementById('select_customer');
const selectSeller = document.getElementById('select_seller');
const birthday = document.getElementById('birthday');
const gender = document.getElementById('gender');
const companyName = document.getElementById('company_name');

// 원래는 한 페이지 내에서 고객과, 판매자를 처리하려했는데, 이게 잘못된 접근이라 아래 코드 사용x.
// 그러나 click 이벤트 침고하기엔 좋아서 일단 남김.
// selectCustomer.addEventListener('click', () => {
//     birthday.style.display = 'flex';
//     gender.style.display = 'flex';
//     companyName.style.display = 'none';
//     selectCustomer.style.backgroundColor = '#F5EFE2';
//     selectCustomer.style.color = '#a43e1d';
//     selectSeller.style.backgroundColor = '#a43e1d';
//     selectSeller.style.color = '#ffffff';
//     // F5EFE2
//     // #a43e1d
//     // ffffff
// });
//
// selectSeller.addEventListener('click', () => {
//     birthday.style.display = 'none';
//     gender.style.display = 'none';
//     companyName.style.display = 'flex';
//     selectCustomer.style.backgroundColor = '#A43E1D';
//     selectCustomer.style.color = '#FFFFFF';
//     selectSeller.style.backgroundColor = '#F5EFE2';
//     selectSeller.style.color = '#A43E1D';
// });


const phoneInput = document.getElementById('user_phone_input');

    phoneInput.addEventListener('input', function(event) {
        const inputText = event.target.value.replace(/-/g, ''); // 하이픈 제거

        if (inputText.startsWith('010') && inputText.length <= 13) {
            let formattedText = inputText;
            if (inputText.length >= 7) {
                formattedText = `${inputText.slice(0, 3)}-${inputText.slice(3, 7)}-${inputText.slice(7, 13)}`;
            } else if (inputText.length >= 3) {
                formattedText = `${inputText.slice(0, 3)}-${inputText.slice(3)}`;
            }
            event.target.value = formattedText;
        } else if (inputText.length > 13) {
            event.target.value = inputText.slice(0, 13); // 13자를 넘어가면 입력 제한
        }
});

const birthdayInput = document.getElementById('user_birthday_input');

    birthdayInput.addEventListener('input', function(event) {
        const inputText = event.target.value.replace(/-/g, ''); // 하이픈 제거

        if (inputText.length <= 10) {
            let formattedText = inputText;
            if (inputText.length >= 5) {
                formattedText = `${inputText.slice(0, 4)}-${inputText.slice(4, 6)}-${inputText.slice(6, 10)}`;
            } else if (inputText.length >= 4) {
                formattedText = `${inputText.slice(0, 4)}-${inputText.slice(4)}`;
            }
            event.target.value = formattedText;
        } else {
            event.target.value = inputText.slice(0, 10); // 10자를 넘어가면 입력 제한
        }
});


//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function userDaumPostcode_register() {
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

function checkPassword() {
    var password = document.getElementById("password_js").value;
    var confirmPassword = document.getElementById("password_check_js").value;

    if (password !== confirmPassword) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
    }
    return true;
}
