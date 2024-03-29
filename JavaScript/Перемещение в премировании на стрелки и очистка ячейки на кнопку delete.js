// Перемещение в премировании на стрелки и очистка ячейки на кнопку delete
// Форма I.ECO.TABEL.BONUS.PERSONS
var DO_CHANGE = true;
var currItem  = null;

form.on('render', function() {
    // обработка кнопок
    ips.fn.hotkey.subscribe(form, 'up down left right delete');
    // делаем форму активной, т.е. с нее будем обрабатывать события
    ips.fn.hotkey.setActiveForm(form);
});
form.on("focus change_ click_", function(data, item, value) {
    // что-то кликнули в форме - делаем форму активной, т.е. с нее будем обрабатывать события
    ips.fn.hotkey.setActiveForm(form);
    if (item == "AMOUNT") {
        currItem = data.path();
    }
});


// Перемещения с клавиатуры по форме
form.on('pressKey:up', function(data, action) {
    if (currItem){
        let arr = currItem.split(".");
        if (parseInt(arr[3]) > 0) {
            arr[3] = parseInt(arr[3])-1;
            $('input[ips-path="'+arr.join(".")+'"]').focus();
        } else {
            $('input[ips-path="'+currItem+'"]').focus();
        }
    }
});
form.on('pressKey:down', function(data, action) {
    if (currItem){
        let arr = currItem.split(".");
        if (parseInt(arr[3]) < form.data.ROWS.length -3) {
            arr[3] = parseInt(arr[3])+1;
            $('input[ips-path="'+arr.join(".")+'"]').focus();
        } else {
            $('input[ips-path="'+currItem+'"]').focus();
        }
    }
});
form.on('pressKey:left', function(data, action) {
    if (currItem){
        let arr = currItem.split(".");
        if (parseInt(arr[5]) > 0) {
            arr[5] = parseInt(arr[5])-1;
            $('input[ips-path="'+arr.join(".")+'"]').focus();
        } else {
            $('input[ips-path="'+currItem+'"]').focus();
        }
    }
});
form.on('pressKey:right', function(data, action) {
    if (currItem){
        let arr = currItem.split(".");
        if (parseInt(arr[5]) < form.data.ROWS[0].CELLS.length-2) {
            arr[5] = parseInt(arr[5])+1;
            $('input[ips-path="'+arr.join(".")+'"]').focus();
        } else {
            $('input[ips-path="'+currItem+'"]').focus();
        }
    }
});
form.on('pressKey:delete', function(data, action) {
    if (currItem){
        let arr = currItem.split(".");
        form.data.ROWS[arr[3]].CELLS[arr[5]].set("AMOUNT", "");
        $('input[ips-path="'+currItem+'"]').focus();
    }
});
