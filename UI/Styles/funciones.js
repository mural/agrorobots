//VALIDACION

    function alfanumerico1(evt) {
        //'Validar punto y coma(;)[59] comilla simple(')[39] guion doble(--)[45] comentarios (/*)[47 y 42] (*/)[42 y 47]
        var charCode = (evt.which) ? evt.which : event.keyCode 
        if (charCode == 59 || charCode == 39) { // [;] [']
            return false;
        }
        // obtener string actual evt.currentTarget.value
        return true;
    }

function alfanumerico2(text) {
    //'Validar punto y coma(;)[59] comilla simple(')[39] guion doble(--)[45] comentarios(/*)[47 y 42](*/)
    while (text.value.indexOf(";") > -1) {
        text.value = text.value.replace(";", "");
    }
    while (text.value.indexOf("'") > -1) {
        text.value = text.value.replace("'", "");
    }
    while (text.value.indexOf("--") > -1) {
        text.value = text.value.replace("--", "");
    }
    while (text.value.indexOf("/*") > -1) {
        text.value = text.value.replace("/*", "");
    }
    while (text.value.indexOf("*/") > -1) {
        text.value = text.value.replace("*/", "");
    }
}
