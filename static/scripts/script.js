//открыть форму для добавления записи
function openFormAdd() {
    const formAdd = document.querySelector('.add-form-container');
    formAdd.classList.add('open');
    const buttonClose = document.querySelector('.close-form-btn');
    //закрыть форму для добавления записи
    buttonClose.addEventListener('click', () => {
        formAdd.classList.remove('open');
    });
};

//открыть форму для редактирования записи
var btnsEditIncome = document.querySelectorAll('.tcol-filter-edit');
const formEdit = document.querySelector('#edit-form-container');
var editDate = document.getElementById('edit-date');
var editFlightId = document.getElementById('edit-flight_id');
var editTypeOfRoute = document.getElementById('edit-type-of-route');
var editTechniqueId = document.getElementById('edit-technique_id');
var editInstructor = document.getElementById('edit-instructor');
var editDiscount = document.getElementById('edit-discount');
var editCheckboxTd = 0;
var editPrice = document.getElementById('edit-price');
var editPaymentType = document.getElementById('edit-payment_type');
var editSourceId = document.getElementById('edit-source_id');
var editNote = document.getElementById('edit-note');

btnsEditIncome.forEach(function (btnEdit) {
    btnEdit.addEventListener('click', () => {
        let trEdit = btnEdit.parentNode.parentNode;
        trEdit.append(formEdit);
        const tdsEditForm = trEdit.children;
        console.log(tdsEditForm);
        setWidthEditForm(tdsEditForm);
        fillEditForm(tdsEditForm);
        formEdit.classList.add('open');
    });
});

//ширина полей формы для редактирования
function setWidthEditForm(data) {
    editDate.style.width = widthSub(data[1].offsetWidth);
    editFlightId.style.width = widthSub(data[2].offsetWidth);
    editTypeOfRoute.style.width = widthSub(data[3].offsetWidth);
    editTechniqueId.style.width = widthSub(data[4].offsetWidth);
    editInstructor.style.width = widthSub(data[5].offsetWidth);
    editDiscount.style.width = widthSub(data[6].offsetWidth);
    document.getElementById('edit-checkbox-td').style.width = widthSub(data[7].offsetWidth);
    editPrice.style.width = widthSub(data[8].offsetWidth);
    editPaymentType.style.width = widthSub(data[9].offsetWidth);
    editSourceId.style.width = widthSub(data[10].offsetWidth);
    editNote.style.width = widthSub(data[11].offsetWidth);
};

function widthSub(str) {
    return (str - 4) + 'px';
};

//заполнить форму для редактирования записи
function fillEditForm(data) {
    document.getElementById('edit-id').value = data[0].innerHTML;
    editDate.value = data[1].innerHTML.slice(6, 10) + '-' + data[1].innerHTML.slice(3, 5) + '-' + data[1].innerHTML.slice(0, 2);
    editFlightId.value = data[2].innerHTML;
    editTypeOfRoute.options[editTypeOfRoute.selectedIndex].text = data[3].innerHTML;
    editTechniqueId.options[editTechniqueId.selectedIndex].text = data[4].innerHTML;
    editInstructor.options[editInstructor.selectedIndex].text = data[5].innerHTML;
    editDiscount.value = data[6].innerHTML;
    document.getElementById('edit-prepayment').checked = data[7].innerHTML === 'Да';
    editPrice.value = data[8].innerHTML;
    editPaymentType.options[editPaymentType.selectedIndex].text = data[9].innerHTML;
    editSourceId.options[editSourceId.selectedIndex].text = data[10].innerHTML;
    editNote.value = data[11].innerHTML;
};

//открыть форму для добавления пользователя в бот
function openFormAddBot() {
    const formAddBot = document.querySelector('#form-new-user-bot');
    formAddBot.classList.add('open');
    const buttonClose = document.querySelector('.close-form-btn');
    //закрыть форму для добавления записи
    buttonClose.addEventListener('click', () => {
        formAddBot.classList.remove('open');
    });
};

var tableBody = document.querySelector('#table-body');
const butttonAddOrder = document.querySelector('#submit');

//butttonAddOrder.addEventListener('click', (event) => {
//formAdd.classList.remove('open');
//event.preventDefault();
//document.querySelector('.add-entry-form').reset();
//});

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
};