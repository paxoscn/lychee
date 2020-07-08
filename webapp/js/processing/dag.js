var hasInstances = false

function renderSVG(dag) {
    // TODO 剪枝

    var jobMap = {}
    for (var i = 0; i < dag.jobs.length; ++i) {
        var job = dag.jobs[i]
        job.deps = []
        jobMap[job.id + ""] = job
    }

    for (var i = 0; i < dag.deps.length; ++i) {
        var dep = dag.deps[i]
        var job = jobMap[dep.job_id + ""]
        if (typeof job == "undefined") {
            continue
        }
        var dependedJob = jobMap[dep.depended_job_id + ""]
        if (typeof dependedJob == "undefined") {
            continue
        }
        job.deps.push(dependedJob)
    }

    hasInstances = dag.instances != null
    if (hasInstances) {
        for (var i = 0; i < dag.instances.length; ++i) {
            var instance = dag.instances[i]
            var job = jobMap[instance.job_id + ""]
            job.instance_id = instance.id
            job.state = instance.state
        }
    }

    var rows = []
    for (var jobId in jobMap) {
        var job = jobMap[jobId]
        var jobMaxSteps = maxSteps(job)
        if (typeof rows[jobMaxSteps] == "undefined") {
            rows[jobMaxSteps] = []
        }
        rows[jobMaxSteps].push(job)
    }

    // TODO 对每一行排序

    var lastRowY = 0
    for (var i = 0; i < rows.length; ++i) {
        var row = rows[i]
        for (var j = 0; j < row.length; ++j) {
            var job = row[j]
            job.y = lastRowY + j * 30
            job.x = row.length > 1 ? ((800 - 300) * j / (row.length - 1)) : ((800 - 300) / 2)
            renderJob(job)
        }
        lastRowY += row.length * 30 + 100
    }
}

function renderJob(job) {
    var foreignObject = document.createElementNS("http://www.w3.org/2000/svg", "foreignObject")
    foreignObject.setAttribute("x", job.x)
    foreignObject.setAttribute("y", job.y)
    foreignObject.setAttribute("width", 300)
    foreignObject.setAttribute("height", 20)
    $("svg").appendChild(foreignObject)

    var node = document.createElement("DIV")

    var nodeColor
    if (typeof job.state == "undefined") {
        nodeColor = "#ccc"
    } else if (job.state == "waiting") {
        nodeColor = "yellow"
    } else if (job.state == "running") {
        nodeColor = "blue"
    } else if (job.state == "successful") {
        nodeColor = "green"
    } else if (job.state == "failed") {
        nodeColor = "red"
    } else {// cancelled
        nodeColor = "grey"
    }
    node.style.backgroundColor = nodeColor
    foreignObject.appendChild(node)

    var checkbox = document.createElement("INPUT")
    checkbox.type = "checkbox"
    checkbox.value = job.id
    node.appendChild(checkbox)

    var name = document.createElement("BUTTON")
    name.obj = job
    name.onclick = editJob
    name.innerHTML = job.name
    node.appendChild(name)

    if (hasInstances) {
        if (typeof job.state == "undefined") {
            checkbox.disabled = true
        } else {
            var log = document.createElement("BUTTON")
            log.obj = job
            log.onclick = viewLog
            log.innerHTML = "日志"
            node.appendChild(log)
        }
    }

    for (var i = 0; i < job.deps.length; ++i) {
        var dependedJob = job.deps[i]
        var line = document.createElementNS("http://www.w3.org/2000/svg", "line")
        line.setAttribute("x1", job.x + 150)
        line.setAttribute("y1", job.y)
        line.setAttribute("x2", dependedJob.x + 150)
        line.setAttribute("y2", dependedJob.y + 20)
        line.setAttribute("stroke", "white")
        $("svg").appendChild(line)
    }
}

function maxSteps(job) {
    if (job.deps.length < 1) {
        return 0
    }
    var max = 0
    for (var i = 0; i < job.deps.length; ++i) {
        max = Math.max(max, maxSteps(job.deps[i]) + 1)
    }
    return max
}

function editJob(e) {
    location = "/processing/job.htm?id=" + e.target.obj.id
}

function viewLog(e) {
    location = "/processing/log.htm?id=" + e.target.obj.instance_id
}
