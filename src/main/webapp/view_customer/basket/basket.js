<!--전체 선택 삭제 / 부분 선택 삭제 구현 script   -->
document.addEventListener("DOMContentLoaded", function () {
    const selectAllButton = document.getElementById("selectAll");
    const selectDeleteButton = document.getElementById("selectDelete");
    const checkboxes = document.querySelectorAll(".product-table tbody input[type='checkbox']");

    selectAllButton.addEventListener("click", function () {
        checkboxes.forEach(function (checkbox) {
            checkbox.checked = true;
        });
        document.querySelectorAll(".product-table tbody tr").forEach(function (row) {
            row.remove();
        });
    });

    selectDeleteButton.addEventListener("click", function () {
        checkboxes.forEach(function (checkbox) {
            if (checkbox.checked) {
                checkbox.closest("tr").remove();
            }
        });
    });
});
