import React, { useContext, useEffect, useState } from "react";
import { Button, Card, Col, Row, Modal, Form, ListGroup, Image, Alert } from "react-bootstrap";
import cookie from "react-cookies";
import { useSearchParams } from "react-router-dom";
import APIs, { authApi, endpoints } from "../../configs/APIs";
import { CartContext } from "../../configs/Contexts";
import MySpinner from "../Commons/MySpinner";

const Home = () => {
    const [products, setProducts] = useState([]);
    const [loading, setLoading] = useState(false);
    const [q, ] = useSearchParams();
    const [page, setPage] = useState(1);
    const [, dispatch] = useContext(CartContext);

    const [selectedProduct1, setSelectedProduct1] = useState(null);
    const [selectedProduct2, setSelectedProduct2] = useState(null);
    const [showCompareModal, setShowCompareModal] = useState(false);

    const [showDetailModal, setShowDetailModal] = useState(false);
    const [selectedProductDetail, setSelectedProductDetail] = useState(null);
    const [comments, setComments] = useState([]);
    const [commentsLoading, setCommentsLoading] = useState(false);
    const [commentContent, setCommentContent] = useState('');
    const [commentError, setCommentError] = useState(null);

    const [showAlert, setShowAlert] = useState(false);

    const loadProducts = async () => {
        setLoading(true);
        try {
            let url = `${endpoints['products']}?page=${page}`;

            let cateId = q.get('cateId');
            if (cateId) {
                url = `${url}&cateId=${cateId}`
                setPage(1);
            } else {
                let kw = q.get('kw');
                if (kw) {
                    url = `${url}&kw=${kw}`;
                    setPage(1);
                }
            }

            let res = await APIs.get(url);
            if (page === 1)
                setProducts(res.data);
            else if (page > 1)
                setProducts(current => {
                    return [...current, ...res.data];
                });
        } catch (ex) {
            console.error(ex);
        } finally {
            setLoading(false);
        }
    }

    useEffect(() => {
        loadProducts();
    }, [q, page]);

    const loadComments = async () => {
        if (!selectedProductDetail) return;

        setCommentsLoading(true);
        try {
            let commentsRes = await APIs.get(`${endpoints['comments']}?productId=${selectedProductDetail.id}`);
            setComments(commentsRes.data);
        } catch (error) {
            console.error("Error fetching comments:", error);
        } finally {
            setCommentsLoading(false);
        }
    }

    useEffect(() => {
        if (selectedProductDetail) {
            loadComments();
        }
    }, [selectedProductDetail]);

    const loadMore = () => {
        if (!loading)
            setPage(page + 1);
    }

    const addToCart = (p) => {
        let cart = cookie.load("cart") || null;
        if (cart === null)
            cart = {};

        if (p.id in cart) {
            // đã có trong giỏ hàng
            cart[p.id]["quantity"]++;
        } else {
            // chưa có trong giỏ hàng
            cart[p.id] = {
                "id": p.id,
                "name": p.name,
                "price": p.price,
                "quantity": 1
            }
        }

        cookie.save("cart", cart);
        dispatch({
            type: 'update-cart',
            payload: countCart()
        })
    }

    const countCart = () => {
        let count = 0;
        let cart = cookie.load("cart") || null;
        if (cart !== null) {
            for (let c of Object.values(cart))
                count += c.quantity;
        }

        return count;
    }

    const handleSelectProduct = (p) => {
        if (!selectedProduct1) {
            setSelectedProduct1(p);
        } else if (!selectedProduct2) {
            setSelectedProduct2(p);
            setShowCompareModal(true); // Hiển thị modal so sánh khi đã chọn đủ hai sản phẩm
        }
    }

    const handleClearSelection = () => {
        setSelectedProduct1(null);
        setSelectedProduct2(null);
        setShowCompareModal(false);
    }

    const handleShowDetailModal = async (p) => {
        setSelectedProductDetail(p);
        setShowDetailModal(true);

        try {
            // Request API để lấy chi tiết sản phẩm
            let detailRes = await APIs.get(`${endpoints['products']}/${p.id}`);
            setSelectedProductDetail(detailRes.data);
        } catch (error) {
            console.error("Error fetching product detail:", error);
        }
    }

    const handleCloseDetailModal = () => {
        setShowDetailModal(false);
        setSelectedProductDetail(null);
        setComments([]);
        setCommentContent('');
        setCommentError(null);
    }

    const handleCommentSubmit = async (event) => {
        event.preventDefault();
        const commentContentTrimmed = commentContent.trim();
        if (!commentContentTrimmed) {
            setCommentError("Vui lòng nhập nội dung bình luận");
            return;
        }

        // Kiểm tra nếu người dùng chưa đăng nhập
        const token = cookie.load('token');
        if (!token) {
            setShowAlert(true);
            return;
        }

        try {
            // Lấy user_id từ token hoặc từ API lấy thông tin người dùng
            const userRes = await authApi().get(endpoints['current-user']);
            const userId = userRes.data.id;

            // Tạo form data để gửi bình luận
            const formData = new FormData();
            formData.append("content", commentContentTrimmed);
            formData.append("product_id", selectedProductDetail.id);
            formData.append("user_id", userId);

            // Gửi bình luận lên server
            await authApi().post(endpoints['comments'], formData);

            // Refresh danh sách bình luận
            await loadComments();
            // Reset nội dung bình luận và lỗi
            setCommentContent('');
            setCommentError(null);
        } catch (error) {
            console.error("Error posting comment:", error);
            setCommentError("Đã xảy ra lỗi khi gửi bình luận");
        }
    }

    

    return (
        <>
            {loading && <MySpinner />}
            <Row>
                {products.map(p => (
                    <Col key={p.id} md={3} xs={12} className='p-2'>
                        <Card>
                            <Card.Img variant="top" src={p.image} />
                            <Card.Body>
                                <Card.Title>{p.name}</Card.Title>
                                <Card.Text>{p.price} VNĐ</Card.Text>
                                <Button variant="primary" className="m-1" onClick={() => handleShowDetailModal(p)}>Xem chi tiết</Button>
                                {selectedProduct1 && selectedProduct1.id === p.id ? (
                                    <Button variant="success" className="m-1" disabled>Đã chọn</Button>
                                ) : selectedProduct2 && selectedProduct2.id === p.id ? (
                                    <Button variant="success" className="m-1" disabled>Đã chọn</Button>
                                ) : (
                                    <Button variant="primary" className="m-1" onClick={() => handleSelectProduct(p)}>So sánh</Button>
                                )}
                                <Button variant="danger" className="m-1" onClick={() => addToCart(p)}>Đặt hàng</Button>
                            </Card.Body>
                        </Card>
                    </Col>
                ))}
            </Row>
            {loading && page > 1 && <MySpinner />}
            <div className="text-center mt-2">
                <Button variant="success" onClick={loadMore}>Xem thêm...</Button>
            </div>

            {/* Modal xem chi tiết */}
            <Modal show={showDetailModal} onHide={handleCloseDetailModal} size="lg">
                <Modal.Header closeButton>
                    <Modal.Title>Chi tiết sản phẩm</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    {selectedProductDetail && (
                        <>
                            <Row>
                                <Col md={6}>
                                    <Image src={selectedProductDetail.image} fluid />
                                </Col>
                                <Col md={6}>
                                <h5>{selectedProductDetail.name}</h5>
                                    <p><strong>Mô tả:</strong> {selectedProductDetail.description}</p>
                                    <p><strong>Nhà sản xuất:</strong> {selectedProductDetail.manufacturer}</p>
                                    <p><strong>Ngày sản xuất:</strong> {selectedProductDetail.created_date ? selectedProductDetail.created_date : 'Không có thông tin'}</p>
                                    <p><strong>Giá:</strong> {selectedProductDetail.price} VNĐ</p>
                                    <p><strong>Tên cửa hàng:</strong> {selectedProductDetail.store_name}</p>
                                    <p><strong>Tình trạng:</strong> Còn Hàng</p>
                                </Col>
                            </Row>

                            <hr />
                            <h5>Danh sách bình luận</h5>
                            <hr />
                            <ListGroup>
                                {comments.map((comment, index) => (
                                    <ListGroup.Item key={index}>
                                        <p><strong>Người dùng:</strong> {comment.userId.firstName} {comment.userId.lastName}</p>
                                        <p>{comment.content}</p>
                                    </ListGroup.Item>
                                ))}
                            </ListGroup>

                            <Form onSubmit={handleCommentSubmit}>
                                <Form.Group controlId="comment">
                                    <Form.Label>Bình luận:</Form.Label>
                                    <Form.Control
                                        as="textarea"
                                        rows={3}
                                        placeholder="Nhập bình luận của bạn..."
                                        value={commentContent}
                                        onChange={(e) => setCommentContent(e.target.value)}
                                    />
                                    {commentError && <p className="text-danger">{commentError}</p>}
                                </Form.Group>
                                <Button variant="primary" type="submit">
                                    Gửi bình luận
                                </Button>
                            </Form>
                        </>
                    )}
                </Modal.Body>
            </Modal>

            {/* Modal so sánh */}
            <Modal show={showCompareModal} onHide={handleClearSelection} size="lg">
                <Modal.Header closeButton>
                    <Modal.Title>So sánh chi tiết</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Row>
                        {/* Sản phẩm thứ nhất */}
                        {selectedProduct1 && (
                            <Col md={6}>
                                <Card>
                                    <Card.Img variant="top" src={selectedProduct1.image} />
                                    <Card.Body>
                                        <Card.Title>{selectedProduct1.name}</Card.Title>
                                        <Card.Text><strong>Giá:</strong> {selectedProduct1.price} VNĐ</Card.Text>
                                        <Card.Text><strong>Mô tả:</strong> {selectedProduct1.description}</Card.Text>
                                        <Card.Text><strong>Nhà sản xuất:</strong> {selectedProduct1.manufacturer}</Card.Text>
                                        <Card.Text><strong>Ngày sản xuất:</strong> {selectedProduct1.created_date ? selectedProduct1.created_date : 'Không có thông tin'}</Card.Text>
                                        <Card.Text><strong>Giá:</strong> {selectedProduct1.price} VNĐ</Card.Text>
                                        <Card.Text><strong>Tình trạng:</strong> Còn Hàng</Card.Text>
                                    </Card.Body>
                                </Card>
                            </Col>
                        )}

                        {/* Sản phẩm thứ hai */}
                        {selectedProduct2 && (
                            <Col md={6}>
                                <Card>
                                    <Card.Img variant="top" src={selectedProduct2.image} />
                                    <Card.Body>
                                        <Card.Title>{selectedProduct2.name}</Card.Title>
                                        <Card.Text><strong>Giá:</strong> {selectedProduct2.price} VNĐ</Card.Text>
                                        <Card.Text><strong>Mô tả:</strong> {selectedProduct2.description}</Card.Text>
                                        <Card.Text><strong>Nhà sản xuất:</strong> {selectedProduct2.manufacturer}</Card.Text>
                                        <Card.Text><strong>Ngày sản xuất:</strong> {selectedProduct2.created_date ? selectedProduct2.created_date : 'Không có thông tin'}</Card.Text>
                                        <Card.Text><strong>Giá:</strong> {selectedProduct2.price} VNĐ</Card.Text>
                                        <Card.Text><strong>Tình trạng:</strong> Còn Hàng</Card.Text>
                                    </Card.Body>
                                </Card>
                            </Col>
                        )}
                    </Row>
                </Modal.Body>
            </Modal>

            {/* Alert thông báo đăng nhập */}
            <Alert show={showAlert} variant="danger" onClose={() => setShowAlert(false)} dismissible>
                <Alert.Heading>Vui lòng đăng nhập</Alert.Heading>
                <p>Bạn cần đăng nhập để có thể bình luận vào sản phẩm này.</p>
            </Alert>
        </>
    );
}

export default Home;
