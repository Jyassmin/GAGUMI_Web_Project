// 숫자와 x만 입력하게 하는 스크립트
document.addEventListener("DOMContentLoaded", function() {
    var textarea = document.getElementById("product-size");
    var alertMessage = document.getElementById("alertMessage");

    textarea.addEventListener("input", function() {
        var inputValue = textarea.value;
        var filteredValue = filterInput(inputValue);

        if (inputValue !== filteredValue) {
            alertMessage.textContent = "숫자와 'x'만 입력해주세요.";
        } else {
            alertMessage.textContent = "";
        }

        textarea.value = filteredValue;
    });

    function filterInput(input) {
        return input.replace(/[^0-9x]/gi, "");
    }
});