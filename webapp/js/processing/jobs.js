window.addEventListener("load", function() {
    ajax('POST', '/api/processing/jobs', {}, function(res) {
        renderSVG(res)
    })
})

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
        var dependedJob = jobMap[dep.depended_job_id + ""]
        job.deps.push(dependedJob)
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
    var div = document.createElement("DIV")
    div.style.backgroundColor = "red"
    div.innerHTML = job.name
    foreignObject.appendChild(div)
    $("svg").appendChild(foreignObject)

    for (var i = 0; i < job.deps.length; ++i) {
        var dependedJob = job.deps[i]
        var line = document.createElementNS("http://www.w3.org/2000/svg", "line")
        line.setAttribute("x1", job.x + 150)
        line.setAttribute("y1", job.y)
        line.setAttribute("x2", dependedJob.x + 150)
        line.setAttribute("y2", dependedJob.y + 20)
        line.setAttribute("stroke", "black")
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