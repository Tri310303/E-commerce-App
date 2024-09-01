package com.dtt.controllers;

import com.dtt.pojo.Comment;
import com.dtt.pojo.CommentDTO;
import com.dtt.pojo.Product;
import com.dtt.pojo.User;
import com.dtt.services.CommentService;
import com.dtt.services.ProductService;
import com.dtt.services.UserService;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/comments")
@CrossOrigin // Cho phép truy cập từ các domain khác
public class ApiCommentController {

    @Autowired
    private CommentService commentService;
    @Autowired
    private UserService userService;
    @Autowired
    private ProductService productService;

    // Endpoint để thêm bình luận mới
    @PostMapping
    public ResponseEntity<String> addComment(@RequestParam("user_id") Integer userId,
                                             @RequestParam("product_id") Integer productId,
                                             @RequestParam("content") String content,
                                             @RequestParam(value = "file", required = false) MultipartFile file) {
        try {
            // Kiểm tra các tham số không null hoặc rỗng
            if (userId == null || productId == null || content == null || content.trim().isEmpty()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("Thông tin người dùng, sản phẩm hoặc nội dung bình luận không hợp lệ");
            }

            // Lấy đối tượng User từ userId
            User userExists = userService.getUserById(userId);
            if (userExists == null) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Người dùng không tồn tại");
            }

            // Lấy đối tượng Product từ productId
            Product productExists = productService.getProductById(productId);
            if (productExists == null) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Sản phẩm không tồn tại");
            }

            // Tạo đối tượng Comment từ dữ liệu nhận được
            Comment comment = new Comment();
            comment.setUserId(userExists); // Gán đối tượng User
            comment.setProductId(productExists); // Gán đối tượng Product
            comment.setContent(content);
            comment.setCreatedDate(new Date()); // Thiết lập ngày tạo

            // Lưu file nếu có
            if (file != null && !file.isEmpty()) {
                // Xử lý lưu file vào hệ thống hoặc cập nhật đường dẫn vào Comment
                // comment.setFile(file);
            }

            // Gọi service để thêm bình luận
            commentService.addComment(comment);

            // Tạo CommentDTO để trả về thông tin đã thêm
            CommentDTO commentDTO = new CommentDTO(comment.getId(), comment.getContent(), comment.getCreatedDate(),
                    comment.getProductId(), comment.getUserId());

            return ResponseEntity.status(HttpStatus.CREATED).body("Thêm bình luận thành công");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Thêm bình luận thất bại: " + e.getMessage());
        }
    }



    
    // Endpoint để cập nhật bình luận
    @PutMapping("/{id}")
    public ResponseEntity<String> updateComment(@PathVariable("id") int id, @RequestBody Comment comment) {
        try {
            comment.setId(id); // Đảm bảo id của bình luận được set
            boolean updated = commentService.updateComment(comment);
            if (updated) {
                return ResponseEntity.ok("Cập nhật bình luận thành công");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Không tìm thấy bình luận để cập nhật");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Cập nhật bình luận thất bại: " + e.getMessage());
        }
    }

    // Endpoint để xóa bình luận theo ID
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteComment(@PathVariable("id") int id) {
        try {
            boolean deleted = commentService.deleteComment(id);
            if (deleted) {
                return ResponseEntity.ok("Xóa bình luận thành công");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Không tìm thấy bình luận để xóa");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Xóa bình luận thất bại: " + e.getMessage());
        }
    }

    // Endpoint để lấy danh sách bình luận theo productId
    @GetMapping
    public ResponseEntity<?> listCommentsByProductId(@RequestParam int productId) {
        try {
            List<Comment> comments = commentService.getCommentsByproductId(productId);
            if (comments.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Không tìm thấy bình luận nào cho productId: " + productId);
            }
            return ResponseEntity.ok(comments);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Lấy danh sách bình luận thất bại: " + e.getMessage());
        }
    }

    // Endpoint để lấy bình luận theo ID
    @GetMapping("/{id}")
    public ResponseEntity<?> getCommentById(@PathVariable("id") int id) {
        try {
            Comment comment = commentService.getCommentById(id);
            if (comment == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Không tìm thấy bình luận");
            }
            return ResponseEntity.ok(comment);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Lấy bình luận thất bại: " + e.getMessage());
        }
    }
}
