window.addEventListener("load", function() {
    ajax('POST', '/api/processing/jobs', {}, function(res) {
        renderSVG(res)
    })
})
