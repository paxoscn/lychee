var dataSource = null

window.addEventListener("load", function() {
    for (var i = 0, radios = document.querySelectorAll("input[type=radio]"); i < radios.length; ++i) {
        radios[i].onchange = function(e) {
            // TODO
        };
    }

    ajax('POST', '/api/system/data-source', { "id": (location.href.indexOf("?") > -1 ? parseInt(location.href.substring(location.href.indexOf("=") + 1)) : 0) }, function(item) {
        dataSource = item
        $("id").value = dataSource.id
        $("driver_" + dataSource.driver).checked = true
        $("name").value = dataSource.name
        $("cn_name").value = dataSource.cn_name
        $("remarks").value = dataSource.remarks
        dataSource.params.forEach(function(item, index) {
            tr($("param-table"), item, [ item.param_name, "<input value='" + item.param_value + "' />" ])
        })
    })
})
