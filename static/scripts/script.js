const buttonOpen = document.querySelector('.add-entry-btn');
const formAdd = document.querySelector('#add-form-container');
const buttonClose = document.querySelector('.close-form-btn');
const formEdit = document.querySelector('#edit-form-container');

//открыть форму для добавления записи
buttonOpen.addEventListener('click', () => {
    formAdd.classList.add('open');
});

//закрыть форму для добавлеиия записи
buttonClose.addEventListener('click', () => {
    formAdd.classList.remove('open');
});

//открыть форму для редактирования записи
var btnsEditIncome = document.querySelectorAll('.tcol-filter-edit');

btnsEditIncome.forEach(function (btnEdit) {
    btnEdit.addEventListener('click', () => {
        let trEdit = btnEdit.parentNode.parentNode;
        trEdit.append(formEdit);
        const data = trEdit.children;
        console.log(data)
        fillEditForm(data);
        formEdit.classList.add('open');
    });
});

//заполнить форму для редактирования записи
function fillEditForm(data) {
    //document.getElementById('edit-id').value = None;
    document.getElementById('edit-date').value = data[0].innerHTML;
    document.getElementById('edit-flight_id').value = data[1].innerHTML;
    document.getElementById('edit-type-of-route').value = data[2].value;
    document.getElementById('edit-technique_id').value = data[3].value;
    document.getElementById('edit-instructor').value = data[4].value;
    document.getElementById('edit-discount').value = data[5].innerHTML;
    //document.getElementById('edit-prepayment').checked = data.prepayment === 'Yes';
    document.getElementById('edit-price').value = data[7].innerHTML;
    document.getElementById('edit-payment_type').value = data[8].value;
    document.getElementById('edit-source_id').value = data[9].value;
    document.getElementById('edit-note').value = data[10].innerHTML;
};

var tableBody = document.querySelector('#table-body');
const butttonAddOrder = document.querySelector('#submit');

function newOrder() {
    var date = document.getElementById('date').value;
    var flight = document.getElementById('flight').value;
    var typeOfRoute = document.getElementById('type-of-route').options[document.getElementById('type-of-route').selectedIndex].text;
    var typeOfTechnique = document.getElementById('type-of-technique').options[document.getElementById('type-of-technique').selectedIndex].text;
    var instructor = document.getElementById('instructor').options[document.getElementById('instructor').selectedIndex].text;
    var discount = document.getElementById('discount').value;
    var prepayment = document.getElementById('prepayment').value;
    var price = document.getElementById('price').value;
    var dtypeOfPayment = document.getElementById('type-of-payment').options[document.getElementById('type-of-payment').selectedIndex].text;
    var source = document.getElementById('source').options[document.getElementById('source').selectedIndex].text;
    var comment = document.getElementById('comment').value;
    return [date, flight, typeOfRoute, typeOfTechnique, instructor, discount, prepayment, price, dtypeOfPayment, source, comment];

};

butttonAddOrder.addEventListener('click', (event) => {
    formAdd.classList.remove('open');
    event.preventDefault();
    document.querySelector('.add-entry-form').reset();
});


const resizers = document.querySelectorAll('.resizer');

resizers.forEach(resizer => {
    resizer.addEventListener('mousedown', initDrag);

    function initDrag(e) {
        const th = e.target.parentElement;
        const startX = e.pageX;
        const startWidth = th.offsetWidth;

        function doDrag(e) {
            th.style.width = (startWidth + e.pageX - startX) + 'px';
        }

        function stopDrag() {
            window.removeEventListener('mousemove', doDrag);
            window.removeEventListener('mouseup', stopDrag);
            localStorage.setItem(th.innerText, th.style.width); // Сохраняем размер в локальное хранилище
        }

        window.addEventListener('mousemove', doDrag);
        window.addEventListener('mouseup', stopDrag);
    }
});

// Восстанавливаем размеры из локального хранилища
const headers = document.querySelectorAll('th');
headers.forEach(header => {
    const savedWidth = localStorage.getItem(header.innerText);
    if (savedWidth) {
        header.style.width = savedWidth;
    }
});

function toggleEdit(id) {
    const editFields = document.getElementById(`edit-fields-${id}`);
    if (editFields.style.display === 'none') {
        editFields.style.display = 'block';
    } else {
        editFields.style.display = 'none';
    }
}