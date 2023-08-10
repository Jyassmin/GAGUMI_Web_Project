
/* input type=text value값 클릭하면 사라지고,
* 다른데 누르면 다시 value값 생기는 함수 */
function clearInputValue(inputField) {
    inputField.value = ""; // 입력 필드의 값 지우기
}
function restoreOriginalValue(inputField) {
    if (inputField.value === "") {
        inputField.value = inputField.defaultValue; // 원래 value 복원
    }
}