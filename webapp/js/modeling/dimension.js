var dimension = null

window.addEventListener("load", function() {
    ajax('POST', '/api/modeling/dimension', { "id": (location.href.indexOf("?") > -1 ? parseInt(location.href.substring(location.href.indexOf("=") + 1)) : 0) }, function(item) {
        dimension = item
        $("id").value = dimension.id
        $("name").value = dimension.name
        $("cn_name").value = dimension.cn_name
        $("remarks").value = dimension.remarks
        $("identity_id").value = dimension.identity_id
        $("identity_name").innerHTML = dimension.identity_name
        $("data_type_" + dimension.data_type).checked = true
        $("desensitization_method_" + dimension.desensitization_method).checked = true
    })
})
