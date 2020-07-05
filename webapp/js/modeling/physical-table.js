var dimension = null

window.addEventListener("load", function() {
    ajax('POST', '/api/modeling/physical-table', { "id": (location.href.indexOf("?") > -1 ? parseInt(location.href.substring(location.href.indexOf("=") + 1)) : 0) }, function(item) {
        dimension = item
        $("id").value = dimension.id
        $("logical_table_id").value = dimension.logical_table_id
        $("logical_table_name").innerHTML = dimension.logical_table_name
        $("data_source_id").value = dimension.data_source_id
        $("data_source_name").innerHTML = dimension.data_source_name
        $("name").value = dimension.name
        $("remarks").value = dimension.remarks
    })
})
