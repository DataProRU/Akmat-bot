const buttonOpen = document.querySelector('.add-entry-btn');
const formAdd = document.querySelector('#add-form-container');
const buttonClose = document.querySelector('.close-form-btn');

//открыть форму для добавления записи
buttonOpen.addEventListener('click', () => {
    formAdd.classList.add('open');
});

//закрыть форму для добавлеиия записи
buttonClose.addEventListener('click', () => {
    formAdd.classList.remove('open');
})

var arrayOrders = [["15.11.2024", 2859, "Софийские водопады", "-вид3-", "-инструктор3-", 8, 3633, 67453, "-вид2-", "-источник3-", "Коммент"],
["15.11.2024", 2859, "Софийские водопады", "-вид1-", "-инструктор3-", 8, 3633, 67453, "--вид2--", "-источник2-", "Коммент"],
["15.11.2024", 2859, "Малый маршрут", "-вид1-", "-инструктор3-", 8, 3633, 67453, "--вид2--", "-источник2-", "Коммент"],
["15.11.2024", 2859, "Софийские водопады", "-вид1-", "-инструктор3-", 8, 3633, 67453, "--вид2--", "-источник2-", "Коммент"],
["15.11.2024", 2859, "Малый маршрут", "-вид1-", "-инструктор3-", 8, 3633, 67453, "--вид2--", "-источник2-", "Коммент"],
["15.11.2024", 2859, "Софийские водопады", "-вид1-", "-инструктор3-", 8, 3633, 67453, "--вид2--", "-источник2-", "Коммент"],
["15.11.2024", 2859, "Смотровые Дукки", "-вид1-", "-инструктор3-", 8, 3633, 67453, "--вид2--", "-источник2-", "Коммент"],
["15.11.2024", 2859, "Софийские водопады", "-вид1-", "-инструктор3-", 8, 3633, 67453, "--вид2--", "-источник2-", "Коммент"],
["15.11.2024", 2859, "Пхия", "-вид1-", "-инструктор3-", 8, 3633, 67453, "--вид2--", "-источник2-", "Коммент"],
["15.11.2024", 2859, "Смотровые Дукки", "-вид1-", "-инструктор3-", 8, 3633, 67453, "--вид2--", "-источник2-", "Коммент"],
];

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

//fillTable(tableBody, arrayOrders);

//функция отрисовки таблицы
//function fillTable(tableBody, arrayOrder) {
//    for (var i = 0; i < arrayOrder.length; i++) {
//      var tr = document.createElement('tr');
//      tr.classList.add('trow');
//    for (var j = 0; j < arrayOrder[i].length; j++) {
//      var td = document.createElement('td');
//    td.innerHTML = arrayOrder[i][j];
//  td.classList.add('tcol');
//if (j === 1 || j === 5 || j === 6 || j === 7) {
//                td.classList.add('tcol-num');
//          }
//        tr.appendChild(td);
//  }

//var td = document.createElement('td');
//        td.classList.add('tcol');
//      td.classList.add('tcol-filter');

//        const tdEdit = document.createElement('button');
//      tdEdit.classList.add('tcol-filter-edit');
//    td.appendChild(tdEdit);

//        const tdDelete = document.createElement('button');
//      tdDelete.classList.add('tcol-filter-delete');
//    td.appendChild(tdDelete);

//        tr.appendChild(td);

//        tableBody.appendChild(tr);
//  }
//};

butttonAddOrder.addEventListener('click', (event) => {
    formAdd.classList.remove('open');
    arrayOrders.push(newOrder());
    event.preventDefault();
    tableBody.innerHTML = '';
    //fillTable(tableBody, arrayOrders);
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
