function runSnippet() {
}

function stopSnippet() {
}

function saveSnippet() {
}

window.addEventListener("load", function() {
    ajax('POST', '/api/processing/load-snippet', {}, function(res) {
        $("updated_on").innerHTML = res.updated_on
        $("snippet").value = res.content
    })
})
