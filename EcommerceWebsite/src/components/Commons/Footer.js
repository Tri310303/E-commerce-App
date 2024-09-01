import { Alert } from "react-bootstrap";
import { NavLink } from "react-router-dom";

const Footer = () => {
    return (
        <div>
            <Alert variant="success" className="mt-1 d-flex justify-content-between align-items-center">
                <span>Huỳnh Võ Đức Trí &copy; 2024</span>
                <NavLink to="/chat" className="text-decoration-none">Chăm sóc khách hàng</NavLink>
            </Alert>
        </div>
    );
}

export default Footer;