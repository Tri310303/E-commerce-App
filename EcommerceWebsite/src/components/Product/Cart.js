import React, { useState, useEffect } from "react";
import { Button, Form, Table, Alert } from "react-bootstrap";
import cookie from "react-cookies";

const Cart = () => {
    const initialCart = cookie.load("cart") || {};
    const [cart, setCart] = useState(initialCart);
    const [totalPrice, setTotalPrice] = useState(0);
    const [showAlert, setShowAlert] = useState(false);

    useEffect(() => {
        calculateTotalPrice();
    }, [cart]);

    const calculateTotalPrice = () => {
        let total = 0;
        Object.values(cart).forEach((item) => {
            const price = parseFloat(item.price);
            const quantity = parseInt(item.quantity);
            if (!isNaN(price) && !isNaN(quantity)) {
                total += price * quantity;
            }
        });
        setTotalPrice(total);
        localStorage.setItem("totalPrice", total); // Lưu totalPrice vào localStorage
    };

    const handleQuantityChange = (e, id) => {
        const value = parseInt(e.target.value);
        if (!isNaN(value) && value >= 0) {
            const updatedCart = {
                ...cart,
                [id]: {
                    ...cart[id],
                    quantity: value.toString(),
                },
            };
            setCart(updatedCart);
            cookie.save("cart", updatedCart);
        }
    };

    const handleRemoveItem = (id) => {
        const { [id]: removedItem, ...updatedCart } = cart;
        setCart(updatedCart);
        if (Object.keys(updatedCart).length === 0) {
            cookie.remove("cart");
        } else {
            cookie.save("cart", updatedCart);
        }
        setShowAlert(true);
    };

    const addToCart = (p) => {
        let cartData = cookie.load("cart") || {};
        if (p.id in cartData) {
            cartData[p.id]["quantity"]++;
        } else {
            cartData[p.id] = {
                id: p.id,
                name: p.name,
                price: p.price,
                quantity: 1,
            };
        }
        cookie.save("cart", cartData);
        setCart(cartData); // Update state of cart
    };

    const countCart = () => {
        let count = 0;
        let cartData = cookie.load("cart") || {};
        for (let c of Object.values(cartData)) {
            count += c.quantity;
        }
        return count;
    };

    return (
        <>
            <h1 className="text-center text-info mt-1">GIỎ HÀNG</h1>
            {Object.keys(cart).length === 0 ? (
                <p>Không có sản phẩm trong giỏ!</p>
            ) : (
                <>
                    {showAlert && (
                        <Alert
                            variant="success"
                            onClose={() => setShowAlert(false)}
                            dismissible
                            className="mt-3"
                        >
                            Sản phẩm đã được xóa khỏi giỏ hàng thành công!
                        </Alert>
                    )}
                    <Table striped bordered hover>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Tên sản phẩm</th>
                                <th>Đơn giá</th>
                                <th>Số lượng</th>
                                <th></th>
                            </tr>
                        </thead>

                        <tbody>
                            {Object.values(cart).map((item, index) => (
                                <tr key={item.id}>
                                    <td>{index + 1}</td>
                                    <td>{item.name}</td>
                                    <td>{parseFloat(item.price).toFixed(2)}</td>
                                    <td>
                                        <Form.Control
                                            type="number"
                                            value={item.quantity}
                                            onChange={(e) =>
                                                handleQuantityChange(e, item.id)
                                            }
                                        />
                                    </td>
                                    <td>
                                        <Button
                                            variant="danger"
                                            onClick={() =>
                                                handleRemoveItem(item.id)
                                            }
                                        >
                                            &times;
                                        </Button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </Table>

                    <div className="text-right">
                        <h4>Tổng tiền: {totalPrice.toFixed(2)} VNĐ</h4>
                        <Button
                            variant="success"
                            className="mt-1"
                            href="/payment"
                        >
                            Thanh toán
                        </Button>
                    </div>
                </>
            )}
        </>
    );
};

export default Cart;
