import React, { useState, useEffect } from 'react';
import { Container, Form, Button, Row, Col, Alert } from 'react-bootstrap';
import APIs, { endpoints } from "../../configs/APIs";

const Payment = () => {
    const [paymentMethod, setPaymentMethod] = useState('');
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [address, setAddress] = useState('');
    const [showAlert, setShowAlert] = useState(false);
    const [totalPrice, setTotalPrice] = useState(0);
    const [amountInUSD, setAmountInUSD] = useState(0);
    const [errorMessage, setErrorMessage] = useState('');

    useEffect(() => {
        const price = localStorage.getItem("totalPrice");
        if (price) {
            const priceInVND = parseFloat(price);
            setTotalPrice(priceInVND);
            setAmountInUSD((priceInVND / 25000).toFixed(2));
        }

        // Xử lý khi được redirect từ PayPal về confirmUrl
        const urlParams = new URLSearchParams(window.location.search);
        const paymentId = urlParams.get('paymentId');
        const PayerID = urlParams.get('PayerID');

        if (paymentId && PayerID) {
            confirmPayment(paymentId, PayerID);
        }

        // Xử lý khi được redirect từ PayPal về cancelUrl
        const cancelStatus = urlParams.get('status');
        if (cancelStatus && cancelStatus === 'cancelled') {
            setErrorMessage('Thanh toán đã bị hủy bỏ.');
        }
    }, []);

    const handlePaymentMethodChange = (e) => {
        setPaymentMethod(e.target.value);
    };

    const handleNameChange = (e) => {
        setName(e.target.value);
    };

    const handleEmailChange = (e) => {
        setEmail(e.target.value);
    };

    const handleAddressChange = (e) => {
        setAddress(e.target.value);
    };

    const handlePaymentSubmit = async (e) => {
        e.preventDefault();

        if (paymentMethod === '') {
            alert('Vui lòng chọn hình thức thanh toán.');
            return;
        }

        if (paymentMethod === 'cash' && (name === '' || email === '' || address === '')) {
            alert('Vui lòng nhập đầy đủ thông tin để nhận hàng.');
            return;
        }

        try {
            let requestData = {
                amount: amountInUSD,
                description: 'Payment for goods' // Mô tả đơn hàng
            };

            if (paymentMethod === 'cash') {
                requestData.name = name;
                requestData.email = email;
                requestData.address = address;
            }

            const response = await APIs.post(endpoints.payment, requestData);

            if (response.status === 200) {
                const approvalUrl = response.data;
                window.location.href = approvalUrl; // Chuyển hướng đến URL PayPal sandbox
            } else {
                setErrorMessage('Đã xảy ra lỗi khi xử lý thanh toán. Vui lòng thử lại.');
            }
        } catch (error) {
            console.error(error);
            setErrorMessage('Đã xảy ra lỗi khi xử lý thanh toán. Vui lòng thử lại.');
        }

        // Reset form
        setPaymentMethod('');
        setName('');
        setEmail('');
        setAddress('');

        // Show success message
        setShowAlert(true);

        // Clear success message after 3 seconds
        setTimeout(() => {
            setShowAlert(false);
        }, 1000000);
    };

    const confirmPayment = async (paymentId, PayerID) => {
        try {
            const confirmResponse = await APIs.get(`/api/payment/confirm?paymentId=${paymentId}&PayerID=${PayerID}`);

            if (confirmResponse.status === 200) {
                // Xử lý khi thanh toán thành công
                setShowAlert(true); // Hiển thị alert thông báo thanh toán thành công
            } else {
                // Xử lý khi thanh toán không thành công
                setErrorMessage('Thanh toán không thành công. Vui lòng thử lại.');
            }
        } catch (error) {
            console.error(error);
            setErrorMessage('Đã xảy ra lỗi khi xử lý thanh toán. Vui lòng thử lại.');
        }
    };

    return (
        <Container className="mt-4">
            <h2 className="text-center text-info mb-4">Chọn hình thức thanh toán</h2>
            <Row className="justify-content-center">
                <Col md={6}>
                    <Form onSubmit={handlePaymentSubmit}>
                        <Form.Group controlId="formPaymentMethod">
                            <Form.Label>Hình thức thanh toán</Form.Label>
                            <Form.Select onChange={handlePaymentMethodChange} required>
                                <option value="">Chọn hình thức thanh toán</option>
                                <option value="cash">Tiền mặt khi nhận hàng</option>
                                <option value="paypal">PayPal</option>
                                <option value="stripe">Stripe</option>
                                <option value="zalopay">Zalo Pay</option>
                                <option value="momo">Momo</option>
                            </Form.Select>
                        </Form.Group>
                        {paymentMethod === 'cash' && (
                            <div>
                                <h3 className="text-center text-info mt-4">
                                    Nhập thông tin thanh toán cho tiền mặt khi nhận hàng
                                </h3>
                                <Form.Group controlId="formName">
                                    <Form.Label>Tên người nhận</Form.Label>
                                    <Form.Control
                                        type="text"
                                        placeholder="Nhập tên người nhận"
                                        value={name}
                                        onChange={handleNameChange}
                                        required
                                    />
                                </Form.Group>
                                <Form.Group controlId="formEmail">
                                    <Form.Label>Email</Form.Label>
                                    <Form.Control
                                        type="email"
                                        placeholder="Nhập email"
                                        value={email}
                                        onChange={handleEmailChange}
                                        required
                                    />
                                </Form.Group>
                                <Form.Group controlId="formAddress">
                                    <Form.Label>Địa chỉ giao hàng</Form.Label>
                                    <Form.Control
                                        as="textarea"
                                        placeholder="Nhập địa chỉ giao hàng"
                                        value={address}
                                        onChange={handleAddressChange}
                                        required
                                    />
                                </Form.Group>
                            </div>
                        )}
                        {paymentMethod === 'paypal' && (
                            <div>
                                <h3 className="text-center text-info mt-4">
                                    Tổng tiền thanh toán: {amountInUSD} USD
                                </h3>
                            </div>
                        )}
                        <Button variant="primary" type="submit">
                            Thanh toán
                        </Button>
                    </Form>
                    {showAlert && (
                        <Alert variant="success" className="mt-3">
                            <p>Đặt hàng thành công! Đơn hàng của quý khách đã được ghi nhận.</p>
                            <Button variant="outline-primary" href="/" className="mt-2">
                                Trang chủ
                            </Button>
                        </Alert>
                    )}
                    {errorMessage && (
                        <Alert variant="danger" className="mt-3">
                            <p>{errorMessage}</p>
                        </Alert>
                    )}
                </Col>
            </Row>
        </Container>
    );
};

export default Payment;