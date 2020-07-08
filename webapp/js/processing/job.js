var job = null

window.addEventListener("load", function() {
    var idName = location.href.substring(location.href.indexOf("?") + 1, location.href.indexOf("="))
    var idValue = parseInt(location.href.substring(location.href.indexOf("=") + 1))
    var req = {}
    req[idName] = idValue
    ajax('POST', '/api/processing/job', req, function(item) {
        job = item
        $("id").value = job.id
        $("flow_id").value = job.flow_id
        $("name").value = job.name
        $("queries").value = job.queries
        job.dependencies.forEach(function(item) {
            trDependency(item)
        })
    })
})

function removeDependency(e) {
    var tr_ = getTr(e)
    var dependency = tr_.obj

    var dependencies = []
    job.dependencies.forEach(function(item) {
        if (item != dependency) {
            dependencies.push(item)
        }
    })
    job.dependencies = dependencies

    tr_.parentNode.removeChild(tr_)
}

function selectDependencies() {
    ajax('POST', '/api/processing/jobs', { "id": job.flow_id }, function(res) {
        showItemSelector($("dependency_selecting_button"), $("dependency_selector"), true, res.jobs, function(item) {
            return [ item.name ]
        }, function(item) {
            var dependency = {}
            dependency.depended_job_id = item.id
            dependency.name = item.name
            job.dependencies.push(dependency)
            trDependency(dependency)
        })
    })
}

function trDependency(item) {
    tr($("dependency-table"), item, [ item.name, "<button onclick='removeDependency(event)'>移除</button>" ])
}

function saveJob() {
    job.name = $("name").value
    job.queries = $("queries").value
    ajax('POST', '/api/processing/job-saving', job, function(res) {
        location = "/processing/jobs.htm?id=" + job.flow_id
    })
}
