var logicalTable = null

function onPartLoad() {
    logicalTable = partInput
    $("id").value = logicalTable.id
    $("layer_" + logicalTable.layer).checked = true
    $("name").value = logicalTable.name
    $("cn_name").value = logicalTable.cn_name
    $("remarks").value = logicalTable.remarks
    $("has_oneid_" + logicalTable.has_oneid).checked = true
    $("is_fact_" + logicalTable.is_fact).checked = true
    logicalTable.dimension_columns.forEach(function(item) {
        trColumn("dimension-table", item, $("dimension-table").getElementsByTagName("TR").length)
    })
    logicalTable.metrics_columns.forEach(function(item) {
        trColumn("metrics-table", item, $("metrics-table").getElementsByTagName("TR").length)
    })
}

function trColumn(tableId, item, index) {
    var cols = [
            "<label><input type='radio' name='" + tableId + "_column_" + index + "_is_indexed' value='1' " + (item.is_indexed == 1 ? "checked" : "") + " onchange='onIsIndexedChanged(event)' />是</label>"
                       + "<label><input type='radio' name='" + tableId + "_column_" + index + "_is_indexed' value='0' " + (item.is_indexed != 1 ? "checked" : "") + " onchange='onIsIndexedChanged(event)' />否</label>",
            "<input name='column_name' value='" + item.name + "' onkeyup='onColumnNameChanged(event)' />",
            "<input name='column_cn_name' value='" + item.cn_name + "' onkeyup='onColumnCnNameChanged(event)' />",
            "" ]
    if (typeof item.identity_id != "undefined") {
        cols.push("")
        cols.push("")
        cols.push("")
    }
    cols.push("<button onclick='removeColumn(event)'>移除</button><button onclick='moveColumn(event)'>移动</button>")
    var newTr = tr($(tableId), item, cols)

    renderRef(newTr)
}

function addDimensionColumn() {
    var column = { 'id': 0, 'name': '', 'cn_name': '', 'remarks': '', 'dimension_id': 0, 'metrics_id': 0, 'is_indexed': 0, 'identity_id': 0, 'data_type': 'string', 'desensitization_method': '', 'ref_name': '', 'identity_name': '' }
    logicalTable.dimension_columns.push(column)
    trColumn("dimension-table", column, $("dimension-table").getElementsByTagName("TR").length)
}

function addMetricsColumn() {
    var column = { 'id': 0, 'name': '', 'cn_name': '', 'remarks': '', 'dimension_id': -1, 'metrics_id': 0, 'is_indexed': 0, 'ref_name': '', 'identity_name': '' }
    logicalTable.metrics_columns.push(column)
    trColumn("metrics-table", column, $("metrics-table").getElementsByTagName("TR").length)
}

function moveColumn(e) {
    var tr_ = getTr(e)
    var column = tr_.obj
    var isMetrics = column.dimension_id < 0

    removeColumn(e)

    if (isMetrics) {
        column = { 'id': column.id, 'name': column.name, 'cn_name': column.cn_name, 'remarks': column.remarks, 'dimension_id': 0, 'metrics_id': 0, 'is_indexed': 0, 'identity_id': 0, 'data_type': 'string', 'desensitization_method': '', 'ref_name': '', 'identity_name': '' }
        logicalTable.dimension_columns.push(column)
        trColumn("dimension-table", column, $("dimension-table").getElementsByTagName("TR").length)
    } else {
        column = { 'id': column.id, 'name': column.name, 'cn_name': column.cn_name, 'remarks': column.remarks, 'dimension_id': -1, 'metrics_id': 0, 'is_indexed': 0, 'ref_name': '', 'identity_name': '' }
        logicalTable.metrics_columns.push(column)
        trColumn("metrics-table", column, $("metrics-table").getElementsByTagName("TR").length)
    }
}

function removeColumn(e) {
    var tr_ = getTr(e)
    var column = tr_.obj

    var dimension_columns = []
    logicalTable.dimension_columns.forEach(function(item) {
        if (item != column) {
            dimension_columns.push(item)
        }
    })
    logicalTable.dimension_columns = dimension_columns

    var metrics_columns = []
    logicalTable.metrics_columns.forEach(function(item) {
        if (item != column) {
            metrics_columns.push(item)
        }
    })
    logicalTable.metrics_columns = metrics_columns

    tr_.parentNode.removeChild(tr_)
}

function unbindRef(e) {
    var tr_ = getTr(e)
    var column = tr_.obj
    var isMetrics = column.dimension_id < 0
    if (isMetrics) {
        column.metrics_id = 0
    } else {
        column.dimension_id = 0
    }
    column.ref_name = ""

    renderRef(tr_)
}

function renderRef(newTr) {
    var column = newTr.obj
    var isMetrics = column.dimension_id < 0
    if (isMetrics) {
        if (column.metrics_id > 0) {
            newTr.getElementsByTagName("TD")[3].innerHTML = column.ref_name + "<button onclick='bindRef(event)'>绑定</button><button onclick='unbindRef(event)'>解绑</button>"
        } else {
            newTr.getElementsByTagName("TD")[3].innerHTML = "<button onclick='bindRef(event)'>绑定</button><button onclick='unbindRef(event)'>解绑</button>"
        }
    } else {
        if (column.dimension_id > 0) {
            newTr.getElementsByTagName("TD")[3].innerHTML = column.ref_name + "<button onclick='bindRef(event)'>绑定</button><button onclick='unbindRef(event)'>解绑</button>"
            newTr.getElementsByTagName("TD")[4].innerHTML = column.identity_name + ""
            newTr.getElementsByTagName("TD")[5].innerHTML = column.data_type
            newTr.getElementsByTagName("TD")[6].innerHTML = column.desensitization_method
        } else {
            newTr.getElementsByTagName("TD")[3].innerHTML = "<button onclick='bindRef(event)'>绑定</button><button onclick='unbindRef(event)'>解绑</button>"
            newTr.getElementsByTagName("TD")[4].innerHTML = column.identity_name + "<button onclick='bindIdentity(event)'>绑定</button><button onclick='unbindIdentity(event)'>解绑</button>"
            newTr.getElementsByTagName("TD")[5].innerHTML = "<select onchange='selectDataType(event)'><option value='string'>string</option><option value='number'>number</option><option value='boolean'>boolean</option><option value='enum'>enum</option><option value='time'>time</option></select>"
            newTr.getElementsByTagName("TD")[6].innerHTML = "<select onchange='selectDesensitizationMethod(event)'><option value=''>无</option><option value='clean'>清除</option><option value='md5'>MD5</option><option value='sha1'>SHA-1</option><option value='sha256'>SHA-256</option></select>"
        }
    }
}

function onLayerChanged(e) {
    logicalTable.layer = e.target.value
}

function onNameChanged(e) {
    logicalTable.name = e.target.value
}

function onCnNameChanged(e) {
    logicalTable.cn_name = e.target.value
}

function onRemarksChanged(e) {
    logicalTable.remarks = e.target.value
}

function onHasOneidChanged(e) {
    logicalTable.has_oneid = parseInt(e.target.value)
}

function onIsFactChanged(e) {
    logicalTable.is_fact = parseInt(e.target.value)
}

function onIsIndexedChanged(e) {
    var column = getTr(e).obj
    column.is_indexed = parseInt(e.target.value)
}

function onColumnNameChanged(e) {
    var column = getTr(e).obj
    column.name = e.target.value
}

function onColumnCnNameChanged(e) {
    var column = getTr(e).obj
    column.cn_name = e.target.value
}

function selectDataType(e) {
    var column = getTr(e).obj
    column.data_type = e.target.getElementsByTagName("OPTION")[e.target.selectedIndex].value
}

function selectDesensitizationMethod(e) {
    var column = getTr(e).obj
    column.desensitization_method = e.target.getElementsByTagName("OPTION")[e.target.selectedIndex].value
}

function bindRef(e) {
    var tr_ = getTr(e)
    var column = tr_.obj
    var isMetrics = column.dimension_id < 0
    if (isMetrics) {
        ajax('POST', '/api/modeling/metrics-list', {}, function(dimensions) {
            showItemSelector(e.target, $("metrics_selector"), false, dimensions, function(item) {
                return [ item.name, item.cn_name ]
            }, function(item) {
                column.metrics_id = item.id
                column.ref_name = item.name
                renderRef(tr_)
            })
        })
    } else {
        ajax('POST', '/api/modeling/dimensions', {}, function(dimensions) {
            showItemSelector(e.target, $("dimension_selector"), false, dimensions, function(item) {
                return [ item.name, item.cn_name, item.identity_id, item.data_type, item.desensitization_method ]
            }, function(item) {
                column.dimension_id = item.id
                column.ref_name = item.name
                column.identity_name = item.identity_name
                column.data_type = item.data_type
                column.desensitization_method = item.desensitization_method
                renderRef(tr_)
            })
        })
    }
}

function bindIdentity(e) {
    var tr_ = getTr(e)
    var column = tr_.obj
    ajax('POST', '/api/modeling/identities', {}, function(identities) {
        showItemSelector(e.target, $("identity_selector"), false, identities, function(item) {
            return [ item.name, item.cn_name ]
        }, function(item) {
            column.identity_id = item.id
            column.identity_name = item.name
            renderRef(tr_)
        })
    })
}

function unbindIdentity(e) {
    var tr_ = getTr(e)
    var column = tr_.obj
    column.identity_id = 0
    column.identity_name = ""
    renderRef(tr_)
}

function selectMultipleDimensions() {
    ajax('POST', '/api/modeling/dimensions', {}, function(dimensions) {
        showItemSelector($("dimension_selecting_button"), $("dimension_selector"), true, dimensions, function(item) {
            return [ item.name, item.cn_name, item.identity_id, item.data_type, item.desensitization_method ]
        }, function(item) {
            item.dimension_id = item.id
            item.ref_name = item.name
            trColumn("dimension-table", item, $("dimension-table").getElementsByTagName("TR").length)
        })
    })
}

function selectMultipleMetrics() {
    ajax('POST', '/api/modeling/metrics-list', {}, function(metrics) {
        showItemSelector($("metrics_selecting_button"), $("metrics_selector"), true, metrics, function(item) {
            return [ item.name, item.cn_name ]
        }, function(item) {
            item.metrics_id = item.id
            item.ref_name = item.name
            trColumn("metrics-table", item, $("metrics-table").getElementsByTagName("TR").length)
        })
    })
}

function saveLogicalTables(req) {
    ajax('POST', '/api/modeling/logical-tables-saving', req, function(res) {
        location.reload()
    })
}
