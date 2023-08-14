const selectCustomer = document.getElementById('select_customer');
const selectSeller = document.getElementById('select_seller');
const birthday = document.getElementById('birthday');
const gender = document.getElementById('gender');
const companyName = document.getElementById('company_name');

selectCustomer.addEventListener('click', () => {
    birthday.style.display = 'flex';
    gender.style.display = 'flex';
    companyName.style.display = 'none';
    selectCustomer.style.backgroundColor = '#F5EFE2';
    selectCustomer.style.color = '#a43e1d';
    selectSeller.style.backgroundColor = '#a43e1d';
    selectSeller.style.color = '#ffffff';
    // F5EFE2
    // #a43e1d
    // ffffff
});

selectSeller.addEventListener('click', () => {
    birthday.style.display = 'none';
    gender.style.display = 'none';
    companyName.style.display = 'flex';
    selectCustomer.style.backgroundColor = '#A43E1D';
    selectCustomer.style.color = '#FFFFFF';
    selectSeller.style.backgroundColor = '#F5EFE2';
    selectSeller.style.color = '#A43E1D';
});

function checkPassword() {
    var password = document.getElementById("password_js").value;
    var confirmPassword = document.getElementById("password_check_js").value;

    if (password !== confirmPassword) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
    }
    return true;
}