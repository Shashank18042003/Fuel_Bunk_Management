        </div><!-- /.fc-content -->
    </div><!-- /.fc-main -->
</div><!-- /.fc-layout -->

<script>
// Auto-dismiss alerts after 5 seconds
document.querySelectorAll('.fc-alert').forEach(function(el) {
    setTimeout(function() {
        el.style.transition = 'opacity 0.4s';
        el.style.opacity = '0';
        setTimeout(function() { el.remove(); }, 400);
    }, 5000);
});

// Mobile sidebar toggle
document.addEventListener('DOMContentLoaded', function() {
    const sidebar = document.getElementById('sidebar');
    // Swipe / hamburger for mobile (basic toggle)
    window.toggleSidebar = function() {
        sidebar && sidebar.classList.toggle('open');
    };
});
</script>
${extraScripts}
</body>
</html>
