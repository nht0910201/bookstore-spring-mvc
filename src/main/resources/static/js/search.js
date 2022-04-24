function Found (url) {
    find = $('#search').val();
    if (find === '') {
        alert('Please enter a valid value');
    } else {
        location.href = url + "/Search?search=" + find;
    }
}

function SortDecPrice (a){
    var url_string = window.location.href
    var url = new URL(url_string);
    var c = url.searchParams.get("search");
    if(c==='')
    {
        alert('Please enter a valid value');
    }
    else{
        location.href = a+"/Search/SortDecPrice?search="+c;
    }
}
function SortIncPrice (a){
    var url_string = window.location.href
    var url = new URL(url_string);
    var c = url.searchParams.get("search");
    if(find==='')
    {
        alert('Please enter a valid value');
    }
    else{
        location.href = a+"/Search/SortIncPrice?search="+c;
    }
}