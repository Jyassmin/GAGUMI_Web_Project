const selectCustomer = document.getElementById('select_customer');
const selectSeller = document.getElementById('select_seller');

selectCustomer.addEventListener('click', () => {
    selectCustomer.style.backgroundColor = '#F5EFE2';
    selectCustomer.style.color = '#a43e1d';
    selectSeller.style.backgroundColor = '#a43e1d';
    selectSeller.style.color = '#ffffff';
    // F5EFE2
    // #a43e1d
    // ffffff
});

selectSeller.addEventListener('click', () => {
    selectCustomer.style.backgroundColor = '#a43e1d';
    selectCustomer.style.color = '#ffffff';
    selectSeller.style.backgroundColor = '#F5EFE2';
    selectSeller.style.color = '#a43e1d';
});