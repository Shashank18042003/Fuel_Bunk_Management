<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Emergency Fuel Order"/>
<c:set var="currentPage" value="user-order-new"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div style="max-width:680px;">
    <!-- Order Limits Info -->
    <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-bottom:24px;">
        <div style="background:rgba(96,165,250,0.08);border:1px solid rgba(96,165,250,0.2);border-radius:10px;padding:14px;">
            <div style="color:var(--fc-petrol);font-weight:700;margin-bottom:4px;">⛽ Petrol Limit</div>
            <div class="fc-mono" style="font-size:22px;font-weight:700;">5 L</div>
            <div style="font-size:11px;color:var(--fc-text-muted);">Per emergency order</div>
        </div>
        <div style="background:rgba(245,158,11,0.08);border:1px solid rgba(245,158,11,0.2);border-radius:10px;padding:14px;">
            <div style="color:var(--fc-diesel);font-weight:700;margin-bottom:4px;">🔧 Diesel Limit</div>
            <div class="fc-mono" style="font-size:22px;font-weight:700;">10 L</div>
            <div style="font-size:11px;color:var(--fc-text-muted);">Per emergency order</div>
        </div>
    </div>

    <!-- Order Form -->
    <div class="fc-card">
        <div class="fc-card-header">
            <span class="fc-card-title">⚡ Place Emergency Delivery</span>
        </div>
        <div class="fc-card-body">
            <form method="post" action="${pageContext.request.contextPath}/user/order/place" id="orderForm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="deliveryLat" id="deliveryLat"/>
                <input type="hidden" name="deliveryLng" id="deliveryLng"/>

                <!-- Branch Selection -->
                <div class="fc-form-group">
                    <label>Select Branch</label>
                    <select name="branchId" class="fc-select" required id="branchSelect"
                            onchange="updateBranchInfo(this.value)">
                        <option value="">— Choose nearest branch —</option>
                        <c:forEach var="branch" items="${branches}">
                            <option value="${branch.id}"
                                data-lat="${branch.latitude}"
                                data-lng="${branch.longitude}"
                                ${selectedBranchId == branch.id ? 'selected' : ''}>
                                ${branch.branchName} — ${branch.city}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Fuel Type -->
                <div class="fc-form-group">
                    <label>Fuel Type</label>
                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">
                        <label style="cursor:pointer;">
                            <input type="radio" name="fuelType" value="PETROL" id="petrolRadio"
                                   ${selectedFuelType == 'PETROL' ? 'checked' : ''}
                                   onchange="updateMaxQty('PETROL')" style="display:none;">
                            <div class="fuel-option-card" id="petrolCard"
                                 style="border:2px solid ${selectedFuelType == 'PETROL' ? 'var(--fc-petrol)' : 'var(--fc-border)'};border-radius:10px;padding:16px;text-align:center;transition:all 0.2s;">
                                <div style="font-size:24px;">⛽</div>
                                <div style="font-weight:700;color:var(--fc-petrol);margin-top:4px;">Petrol</div>
                                <div style="font-size:11px;color:var(--fc-text-muted);">Max 5 Litres</div>
                                <div id="petrolPrice" style="font-size:12px;color:var(--fc-amber);margin-top:4px;font-family:var(--font-mono);">
                                    <c:if test="${not empty selectedInventory && selectedFuelType == 'PETROL'}">
                                        ₹${selectedInventory.pricePerLitre}/L
                                    </c:if>
                                </div>
                            </div>
                        </label>
                        <label style="cursor:pointer;">
                            <input type="radio" name="fuelType" value="DIESEL" id="dieselRadio"
                                   ${selectedFuelType == 'DIESEL' ? 'checked' : ''}
                                   onchange="updateMaxQty('DIESEL')" style="display:none;">
                            <div class="fuel-option-card" id="dieselCard"
                                 style="border:2px solid ${selectedFuelType == 'DIESEL' ? 'var(--fc-diesel)' : 'var(--fc-border)'};border-radius:10px;padding:16px;text-align:center;transition:all 0.2s;">
                                <div style="font-size:24px;">🔧</div>
                                <div style="font-weight:700;color:var(--fc-diesel);margin-top:4px;">Diesel</div>
                                <div style="font-size:11px;color:var(--fc-text-muted);">Max 10 Litres</div>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- Quantity -->
                <div class="fc-form-group">
                    <label>Quantity (Litres)</label>
                    <div style="display:flex;gap:10px;align-items:center;">
                        <input type="number" name="quantityLitres" id="quantityInput"
                               class="fc-input" min="0.5" max="5" step="0.5"
                               placeholder="e.g. 2.5" required style="flex:1;"
                               oninput="calcTotal()">
                        <div id="maxQtyHint" style="font-size:12px;color:var(--fc-text-muted);white-space:nowrap;font-family:var(--font-mono);">Max 5L</div>
                    </div>
                    <!-- Quick Select -->
                    <div style="display:flex;gap:8px;margin-top:8px;flex-wrap:wrap;">
                        <button type="button" class="fc-btn fc-btn-ghost fc-btn-sm" onclick="setQty(1)">1L</button>
                        <button type="button" class="fc-btn fc-btn-ghost fc-btn-sm" onclick="setQty(2)">2L</button>
                        <button type="button" class="fc-btn fc-btn-ghost fc-btn-sm" onclick="setQty(3)">3L</button>
                        <button type="button" class="fc-btn fc-btn-ghost fc-btn-sm" onclick="setQty(5)">5L (Max Petrol)</button>
                        <button type="button" class="fc-btn fc-btn-ghost fc-btn-sm" onclick="setQty(10)">10L (Max Diesel)</button>
                    </div>
                </div>

                <!-- Delivery Address -->
                <div class="fc-form-group">
                    <label>Delivery Location</label>
                    <input type="text" name="deliveryAddress" class="fc-input"
                           placeholder="Enter your current location / road name" id="addressInput">
                    <div style="margin-top:8px;display:flex;gap:8px;flex-wrap:wrap;">
                        <button type="button" class="fc-btn fc-btn-secondary fc-btn-sm" onclick="getLocation()">
                            📍 Use My GPS Location
                        </button>
                        <span id="gpsStatus" style="font-size:11px;color:var(--fc-text-muted);align-self:center;"></span>
                    </div>
                </div>

                <!-- Payment Method -->
                <div class="fc-form-group">
                    <label>Payment Method</label>
                    <select name="paymentMethod" class="fc-select" required>
                        <option value="">— Select Payment —</option>
                        <option value="CASH_ON_DELIVERY">💵 Cash on Delivery</option>
                        <option value="ONLINE_UPI">📱 UPI (Online)</option>
                        <option value="ONLINE_CARD">💳 Card (Online)</option>
                        <option value="ONLINE_NETBANKING">🏦 Net Banking</option>
                    </select>
                </div>

                <!-- Notes -->
                <div class="fc-form-group">
                    <label>Notes (optional)</label>
                    <textarea name="notes" class="fc-textarea fc-input" rows="2"
                              placeholder="e.g. Near the red petrol station sign, call before arriving..."></textarea>
                </div>

                <!-- Order Summary -->
                <div id="orderSummary" style="display:none;background:var(--fc-surface2);border:1px solid var(--fc-border);border-radius:10px;padding:16px;margin-bottom:20px;">
                    <div style="font-size:12px;font-weight:700;letter-spacing:1px;text-transform:uppercase;margin-bottom:12px;color:var(--fc-text-muted);font-family:var(--font-mono);">Order Summary</div>
                    <div class="fc-flex fc-gap-2" style="justify-content:space-between;margin-bottom:6px;">
                        <span style="color:var(--fc-text-muted);">Fuel amount</span>
                        <span class="fc-mono" id="sumFuel">—</span>
                    </div>
                    <div class="fc-flex fc-gap-2" style="justify-content:space-between;margin-bottom:10px;">
                        <span style="color:var(--fc-text-muted);">Delivery charge</span>
                        <span class="fc-mono">₹50.00</span>
                    </div>
                    <div class="fc-flex fc-gap-2" style="justify-content:space-between;border-top:1px solid var(--fc-border);padding-top:10px;">
                        <span style="font-weight:700;">Total</span>
                        <span class="fc-mono" id="sumTotal" style="font-size:18px;font-weight:700;color:var(--fc-amber);">—</span>
                    </div>
                </div>

                <button type="submit" class="fc-btn fc-btn-primary" style="width:100%;justify-content:center;padding:13px;font-size:15px;">
                    ⚡ Place Order — Help is Coming
                </button>
            </form>
        </div>
    </div>
</div>

<c:set var="extraScripts">
<script>
var pricePerLitre = 0;

function updateMaxQty(type) {
    const max = type === 'PETROL' ? 5 : 10;
    document.getElementById('quantityInput').max = max;
    document.getElementById('maxQtyHint').textContent = 'Max ' + max + 'L';
    // Visual selection
    document.getElementById('petrolCard').style.borderColor = type === 'PETROL' ? 'var(--fc-petrol)' : 'var(--fc-border)';
    document.getElementById('dieselCard').style.borderColor = type === 'DIESEL' ? 'var(--fc-diesel)' : 'var(--fc-border)';
    calcTotal();
}

function setQty(v) {
    document.getElementById('quantityInput').value = v;
    calcTotal();
}

function calcTotal() {
    const qty = parseFloat(document.getElementById('quantityInput').value) || 0;
    if (qty > 0 && pricePerLitre > 0) {
        const fuel = qty * pricePerLitre;
        const total = fuel + 50;
        document.getElementById('sumFuel').textContent = '₹' + fuel.toFixed(2) + ' (' + qty + 'L × ₹' + pricePerLitre + ')';
        document.getElementById('sumTotal').textContent = '₹' + total.toFixed(2);
        document.getElementById('orderSummary').style.display = 'block';
    } else {
        document.getElementById('orderSummary').style.display = qty > 0 ? 'block' : 'none';
    }
}

function getLocation() {
    const status = document.getElementById('gpsStatus');
    status.textContent = 'Getting location...';
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(pos) {
            document.getElementById('deliveryLat').value = pos.coords.latitude;
            document.getElementById('deliveryLng').value = pos.coords.longitude;
            document.getElementById('addressInput').value =
                'GPS: ' + pos.coords.latitude.toFixed(5) + ', ' + pos.coords.longitude.toFixed(5);
            status.textContent = '✓ Location captured';
            status.style.color = 'var(--fc-success)';
        }, function() {
            status.textContent = 'Location access denied. Please enter address manually.';
            status.style.color = 'var(--fc-danger)';
        });
    } else {
        status.textContent = 'Geolocation not supported in this browser.';
    }
}

// Onclick on fuel option cards
document.getElementById('petrolCard').addEventListener('click', function() {
    document.getElementById('petrolRadio').checked = true;
    updateMaxQty('PETROL');
});
document.getElementById('dieselCard').addEventListener('click', function() {
    document.getElementById('dieselRadio').checked = true;
    updateMaxQty('DIESEL');
});

// Init selected
<c:if test="${not empty selectedFuelType}">
updateMaxQty('${selectedFuelType}');
<c:if test="${not empty selectedInventory}">
pricePerLitre = ${selectedInventory.pricePerLitre};
</c:if>
</c:if>
</script>
</c:set>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
