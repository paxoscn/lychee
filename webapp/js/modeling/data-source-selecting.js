function selectDataSource() {
    var selector = document.createElement("DIV")
    selector.className = "item_selector"
    selector.innerHTML = "<table><tr><th>驱动</th><th>名称</th><th>中文名称</th><th>描述</th></tr></table>"
    document.body.appendChild(selector)

    ajax('POST', '/api/system/data-sources', {}, function(res) {
        showItemSelector($("data_source_selecting_button"), selector, false, res, function(item) {
            return [ item.driver, item.name, item.cn_name, item.remarks ]
        }, function(item) {
            $("data_source_id").value = item.id
            $("data_source_name").innerHTML = item.name
        })
    })
}