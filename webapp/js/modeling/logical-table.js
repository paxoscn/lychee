window.addEventListener("load", function() {
    ajax('POST', '/api/modeling/logical-table', { "id": (location.href.indexOf("?") > -1 ? parseInt(location.href.substring(location.href.indexOf("=") + 1)) : 0) }, function(item) {
        loadPart($('logical_table'), '/modeling/logical-table.part.htm', item)
    })
})
