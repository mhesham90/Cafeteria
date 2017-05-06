App.products = App.cable.subscriptions.create("ProductsChannel",{
    connected: function() {
        // Called when the subscription is ready for use on the server
    },

    disconnected: function() {
        // Called when the subscription has been terminated by the server
    },

    received: function(data) {
        var product = JSON.parse(data.product);
        if ($('title').text() === "order"){
            if (data.type === 'create') {
                addProduct(product);
            }else if (data.type === 'update'){
                if (product.status === 0){
                    removeProduct(product.id);
                }else{
                    addProduct(product);
                }
            }else if (data.type === 'delete'){
                removeProduct(product.id);
            }
        }else {
            if (data.type === 'update') {
                if (product.status === 0) {
                    $("#unavailable" + product.id).show();
                } else {
                    $("#unavailable" + product.id).hide();
                }
            }
        }
        console.log(data);
    }

});
