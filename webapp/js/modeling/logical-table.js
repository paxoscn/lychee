var logicalTable = null

window.addEventListener("load", function() {
    ajax('POST', '/api/modeling/logical-table', { "id": (location.href.indexOf("?") > -1 ? parseInt(location.href.substring(location.href.indexOf("=") + 1)) : 0) }, function(item) {
        logicalTable = item
        $("id").value = logicalTable.id
        $("layer_" + logicalTable.layer).checked = true
        $("name").value = logicalTable.name
        $("cn_name").value = logicalTable.cn_name
        $("remarks").value = logicalTable.remarks
        $("has_oneid_" + logicalTable.has_oneid).checked = true
        $("is_fact_" + logicalTable.is_fact).checked = true
        logicalTable.columns.filter(function(item) { return item.dimension_id > 0 })
                .forEach(function(item, index) {
            trColumn("dimension-table", item, index)
        })
        logicalTable.columns.filter(function(item) { return item.dimension_id <= 0 })
                .forEach(function(item, index) {
            trColumn("metrics-table", item, index)
        })
    })
})

function selectDimension() {
    ajax('POST', '/api/modeling/dimensions', {}, function(dimensions) {
        showItemSelector($("dimension_selecting_button"), $("dimension_selector"), true, dimensions, function(item) {
            return [ item.name, item.cn_name, item.remarks, item.identity_id, item.data_type, item.desensitization_method ]
        }, function(item) {
            item.dimension_id = item.id
            trColumn("dimension-table", item, $("dimension-table").getElementsByTagName("TR").length)
        })
    })
}

function selectMetrics() {
    ajax('POST', '/api/modeling/metrics-list', {}, function(metrics) {
        showItemSelector($("metrics_selecting_button"), $("metrics_selector"), true, metrics, function(item) {
            return [ item.name, item.cn_name, item.remarks ]
        }, function(item) {
            item.metrics_id = item.id
            trColumn("metrics-table", item, $("metrics-table").getElementsByTagName("TR").length)
        })
    })
}

function trColumn(tableId, item, index) {
    var cols = [
            "<label><input type='radio' name='" + tableId + "_column_" + index + "_is_indexed' value='1' " + (item.is_indexed == 1 ? "checked" : "") + " />是</label>"
                       + "<label><input type='radio' name='" + tableId + "_column_" + index + "_is_indexed' value='0' " + (item.is_indexed != 1 ? "checked" : "") + " />否</label>",
            "<input name='column_name' value='" + item.name + "' />",
            "<input name='column_cn_name' value='" + item.cn_name + "' />",
            "<input name='column_remarks' value='" + item.remarks + "' />" ]
    if (typeof item.identity_id != "undefined") {
        cols.push(item.identity_id)
        cols.push(item.data_type)
        cols.push(item.desensitization_method)
    }
    tr($(tableId), item, cols)
}
