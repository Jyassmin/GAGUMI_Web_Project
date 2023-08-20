<!--전체 선택 삭제 / 부분 선택 삭제 구현 script   -->
function deleteSelectedItems() {
    const checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
    const selectedItems = [];

    checkboxes.forEach(checkbox => {
        selectedItems.push(checkbox.value);
    });

    if (selectedItems.length === 0) {
        return;
    }
}
