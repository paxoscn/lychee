function runSnippet() {
}

function stopSnippet() {
}

function saveSnippet() {
}

window.addEventListener("load", function() {
    ajax('POST', '/api/processing/load-snippet', {}, function(res) {
        $("updated_on").innerHTML = res.updated_on ? res.updated_on : '2020-07-10 20:15:36'
        $("snippet").value = res.content
    })
})
