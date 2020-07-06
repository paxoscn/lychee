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
                    "title": "指标管理",
                    "href": "/modeling/metrics-list.htm"
                },
                {
                    "title": "标识管理",
                    "href": "/modeling/identities.htm"
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
                    "title": "SQL控制台",
                    "href": "/processing/snippet.htm"
                },
                {
                    "title": "任务安排",
                    "href": "/processing/jobs.htm"
                },
                {
                    "title": "任务实例",
                    "href": "/processing/instances.htm"
                }
            ]
        },
        {
            "title": "系统管理",
            "children": [
                {
                    "title": "数据源管理",
                    "href": "/system/data-sources.htm"
                },
                {
                    "title": "模型迁移",
                    "href": "/system/migrations.htm"
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

// Ignores cols whose index are bigger than count of THs.
function tr(table, obj, cols) {
    var thCount = table.getElementsByTagName("th").length
    var tr = document.createElement("tr")
    tr.obj = obj
    var i = 0
    cols.forEach(function(col) {
        if (i++ >= thCount) {
            return
        }
        var td = document.createElement("td")
        td.innerHTML = col
        tr.appendChild(td)
    })
    table.getElementsByTagName("tbody")[0].appendChild(tr)
    return tr
}

var lastSelectorEl = null

function showItemSelector(el, selectorEl, multiple, items, onCols, onSelect) {
    if (lastSelectorEl != null) {
        lastSelectorEl.style.display = "none"
    }
    if (selectorEl.getElementsByClassName("buttons").length < 1) {
        // Init.
        var buttons = document.createElement("DIV")
        buttons.className = "buttons"
        if (multiple) {
            buttons.innerHTML = "<button onclick='selectItems(event)'>Select</button>"
            selectorEl.getElementsByTagName("tr")[0]
                    .insertBefore(document.createElement("TH"), selectorEl.getElementsByTagName("th")[0])
        }
        buttons.innerHTML += "<button onclick='closeSelector()'>Close</button>"
        selectorEl.insertBefore(buttons, selectorEl.getElementsByTagName("table")[0])
    }
    var trs = selectorEl.getElementsByTagName("tr")
    for (var i = trs.length - 1; i > 0; --i) {
        selectorEl.getElementsByTagName("tbody")[0].removeChild(trs[i])
    }
    items.forEach(function(item) {
        var cols = onCols(item)
        if (multiple) {
            cols.unshift("<input type='checkbox' />")
        }
        var newTr = tr(selectorEl.getElementsByTagName("table")[0], { "item": item, "callback": onSelect }, cols)
        if (!multiple) {
            newTr.onclick = onItemSelected
        }
    })

    var absLeft = 0; absTop = 0
    while (el != null) {
        absLeft += el.offsetLeft
        absTop += el.offsetTop
        el = el.offsetParent
    }
    selectorEl.style.display = "block"
    selectorEl.style.left = absLeft + "px"
    selectorEl.style.top = absTop + "px"
    lastSelectorEl = selectorEl
}

function selectItems(e) {
    var trs = e.target.parentNode.parentNode.getElementsByTagName("tr")
    for (var i = 1; i < trs.length; ++i) {
        var tr = trs[i]
        if (tr.getElementsByTagName("input")[0].checked) {
            tr.obj.callback(tr.obj.item)
        }
    }

    lastSelectorEl.style.display = "none"
}

function onItemSelected(e) {
    var el = e.target
    while (el.nodeName != "TR") {
        el = el.parentNode
    }

    el.obj.callback(el.obj.table)

    lastSelectorEl.style.display = "none"
}

window.addEventListener("load", function() {
    initMenu()
})
