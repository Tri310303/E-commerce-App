import React, { useState, useEffect } from 'react';
import { Button, Container, Table, Modal, Form, Image } from 'react-bootstrap';
import APIs, { endpoints, authApi } from "../../configs/APIs";

const Store = () => {
    const initialFormState = {
        name: '',
        address: '',
        phone: '',
        email: '',
        managerId: ''
    };

    const [formData, setFormData] = useState(initialFormState);
    const [shops, setShops] = useState([]);
    const [showModal, setShowModal] = useState(false);
    const [editing, setEditing] = useState(false);
    const [userId, setUserId] = useState('');
    const [error, setError] = useState(null);
    const [imageFile, setImageFile] = useState(null);

    useEffect(() => {
        fetchStores();
        fetchCurrentUser();
    }, []);

    const fetchStores = async () => {
        try {
            const response = await APIs.get(endpoints.stores);
            setShops(response.data);
        } catch (error) {
            console.error('Error fetching stores:', error);
        }
    };

    const fetchCurrentUser = async () => {
        try {
            const userRes = await authApi().get(endpoints['current-user']);
            const userid = userRes.data.id;
            setUserId(userid);
        } catch (error) {
            console.error('Error fetching current user:', error);
        }
    };

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData({ ...formData, [name]: value });
    };

    const handleImageChange = (e) => {
        setImageFile(e.target.files[0]);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        const newShopData = new FormData();
        newShopData.append('name', formData.name);
        newShopData.append('address', formData.address);
        newShopData.append('phone', formData.phone);
        newShopData.append('email', formData.email);
        newShopData.append('manager_id', userId);

        try {
            let response;
            if (editing) {
                response = await APIs.post(`${endpoints.stores}/${formData.id}`, newShopData);
                const updatedShops = shops.map((shop) =>
                    shop.id === formData.id ? response.data : shop
                );
                setShops(updatedShops);
            } else {
                response = await APIs.post(endpoints.stores, newShopData);
                setShops([...shops, response.data]);
            }
            handleClose();
            fetchStores(); // Cập nhật lại danh sách sau khi thêm/cập nhật thành công
        } catch (error) {
            setError('Có lỗi xảy ra khi lưu cửa hàng.');
            console.error('Error saving store:', error);
        }
    };

    const handleOpenModal = (shop) => {
        setFormData(shop ? shop : initialFormState);
        setEditing(!!shop);
        setShowModal(true);
    };

    const handleClose = () => {
        setShowModal(false);
        setFormData(initialFormState);
        setEditing(false);
        setImageFile(null);
    };

    return (
        <Container className="mt-4">
            <h2 className="text-center text-info mb-4">Danh sách cửa hàng</h2>
            <Button
                variant="info"
                className="mb-3"
                onClick={() => handleOpenModal(null)}
            >
                Thêm cửa hàng mới
            </Button>

            <Table striped bordered hover>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Tên cửa hàng</th>
                        <th>Địa chỉ</th>
                        <th>Số điện thoại</th>
                        <th>Email</th>
                        <th>Quản lý</th>
                    </tr>
                </thead>
                <tbody>
                    {shops.map((shop, index) => (
                        <tr key={shop.id}>
                            <td>{index + 1}</td>
                            <td>{shop.name}</td>
                            <td>{shop.address}</td>
                            <td>{shop.phone}</td>
                            <td>{shop.email}</td>
                            <td>{shop.managerId ? `${shop.managerId.firstName} ${shop.managerId.lastName}` : ''}</td>
                        </tr>
                    ))}
                </tbody>
            </Table>

            <Modal show={showModal} onHide={handleClose}>
                <Modal.Header closeButton>
                    <Modal.Title>
                        {editing ? 'Chỉnh sửa cửa hàng' : 'Thêm cửa hàng mới'}
                    </Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Form onSubmit={handleSubmit}>
                        <Form.Group className="mb-3" controlId="formName">
                            <Form.Label>Tên cửa hàng</Form.Label>
                            <Form.Control
                                type="text"
                                placeholder="Nhập tên cửa hàng"
                                name="name"
                                value={formData.name}
                                onChange={handleChange}
                                required
                            />
                        </Form.Group>
                        <Form.Group className="mb-3" controlId="formAddress">
                            <Form.Label>Địa chỉ cửa hàng</Form.Label>
                            <Form.Control
                                type="text"
                                placeholder="Nhập địa chỉ cửa hàng"
                                name="address"
                                value={formData.address}
                                onChange={handleChange}
                                required
                            />
                        </Form.Group>
                        <Form.Group className="mb-3" controlId="formPhone">
                            <Form.Label>Số điện thoại cửa hàng</Form.Label>
                            <Form.Control
                                type="text"
                                placeholder="Nhập số điện thoại cửa hàng"
                                name="phone"
                                value={formData.phone}
                                onChange={handleChange}
                                required
                            />
                        </Form.Group>
                        <Form.Group className="mb-3" controlId="formEmail">
                            <Form.Label>Email</Form.Label>
                            <Form.Control
                                type="email"
                                placeholder="Nhập email"
                                name="email"
                                value={formData.email}
                                onChange={handleChange}
                                required
                            />
                        </Form.Group>
                        <Button variant="primary" type="submit">
                            Lưu
                        </Button>
                    </Form>
                </Modal.Body>
            </Modal>
        </Container>
    );
};

export default Store;
