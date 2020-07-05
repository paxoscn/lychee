var $ = function(id) {
    return document.getElementById(id);
};
var ajax = function(method, path, body, callback) {
    var req = new XMLHttpRequest();
    req.open(method, path, true);
    if (body == null || body.toString().indexOf("FormData") < 0) {
        req.setRequestHeader("Content-Type", "application/json;charset=utf-8");
    }

    var localToken = localStorage.getItem("token")
    if (localToken != null) {
        req.setRequestHeader("Authorization", localToken);
    }

    req.onreadystatechange = function(e) {
        if(this.readyState != 4 || (this.status != 200 && this.status != 304)) {
            return
        }

        var token = this.getResponseHeader("Authorization")
        if (token != null) {
            localStorage.setItem("token", token)
        }

        var res;
        eval("res = " + req.responseText);
        if (res.code != 0) {
            if (res.code == 301) {
                location = "/admin/login.html";
            } else {
                alert("出现错误：" + res.message);
            }
        } else {
            callback(res.body);
        }
    };
    req.send(body == null ? null : body.toString().indexOf("FormData") > -1 ? body : JSON.stringify(body));
}

function initMenu() {
    var menu = [
        {
            "title": "维度建模",
            "children": [
                {
                    "title": "维度管理",
                    "href": "/modeling/dimensions.htm"
                },
                {
                    "title": "逻辑表管理",
                    "href": "/modeling/logical-tables.htm"
                },
                {
                    "title": "物理表管理",
                    "href": "/modeling/physical-tables.htm"
                }
            ]
        },
        {
            "title": "数据处理",
            "children": [
                {
                    "title": "代码任务",
                    "href": "/processing/snippet.htm"
                },
                {
                    "title": "同步任务",
                    "href": "/processing/sync.htm"
                },
                {
                    "title": "任务实例",
                    "children": [
                        {
                            "title": "自动实例",
                            "href": "/processing/instances/auto.htm"
                        },
                        {
                            "title": "手动实例",
                            "href": "/processing/instances/manual.htm"
                        }
                    ]
                }
            ]
        },
        {
            "title": "系统管理",
            "children": [
                {
                    "title": "数据源管理",
                    "href": "/system/sources.htm"
                },
                {
                    "title": "操作审计",
                    "href": "/system/op-logs.htm"
                },
                {
                    "title": "接口审计",
                    "href": "/system/api-logs.htm"
                },
                {
                    "title": "权限管理",
                    "href": "/system/auth.htm"
                }
            ]
        }
    ]

    appendMenuItems($("menu"), menu)
}

function appendMenuItems(el, menu) {
    var ul = document.createElement("ul")

    menu.forEach(function(item) {
        var li = document.createElement("li")
        var title = document.createElement("div")
        var hasChildren = typeof item.children != "undefined"
        title.innerHTML = hasChildren ? item.title : ("<a href='" + item.href + "'>" + item.title + "</a>")
        li.appendChild(title)
        if (hasChildren) {
            var children = document.createElement("div")
            appendMenuItems(children, item.children)
            li.appendChild(children)
        }
        ul.appendChild(li)
    })

    el.appendChild(ul)
}

function tclean(table) {
    var trs = table.getElementsByTagName("tr")
    for (var i = trs.length - 1; i > 0; --i) {
        table.getElementsByTagName("tbody")[0].removeChild(trs[i])
    }
}

function tr(table, obj, cols) {
    var tr = document.createElement("tr")
    tr.obj = obj
    cols.forEach(function(col) {
        var td = document.createElement("td")
        td.innerHTML = col
        tr.appendChild(td)
    })
    table.getElementsByTagName("tbody")[0].appendChild(tr)
}

function showTableSelector(el, tables, onSelect) {
    var trs = $("table_selector").getElementsByTagName("tr")
    for (var i = trs.length - 1; i > 0; --i) {
        $("table_selector").getElementsByTagName("tbody")[0].removeChild(trs[i])
    }
    tables.forEach(function(table) {
        tr($("table_selector").getElementsByTagName("table")[0], { "table": table, "callback": onSelect }, [ table.SourceName, table.Name, "<button onclick='onTableSelected(event);'>Select</button>" ])
    })

    var absLeft = 0; absTop = 0
    while (el != null) {
        absLeft += el.offsetLeft
        absTop += el.offsetTop
        el = el.offsetParent
    }
    $("table_selector").style.display = "block"
    $("table_selector").style.left = absLeft + "px"
    $("table_selector").style.top = absTop + "px"
}

function onTableSelected(e) {
    var el = e.target                                                                                                                                                        
    while (el.nodeName != "TR") {
        el = el.parentNode
    }

    el.obj.callback(el.obj.table)

    $("table_selector").style.display = "none"
}

window.addEventListener("load", function() {
    initMenu()
})
