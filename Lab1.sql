CREATE TABLE KhachHang (
    customer_id   SERIAL         PRIMARY KEY,
    ten_kh        VARCHAR(100)   NOT NULL,
    so_dien_thoai VARCHAR(15)    NOT NULL UNIQUE,
    dia_chi       VARCHAR(255)
);
CREATE TABLE SanPham (
    product_id       SERIAL         PRIMARY KEY,
    ten_sp           VARCHAR(200)   NOT NULL,
    don_gia_hien_tai DECIMAL(12, 2) NOT NULL DEFAULT 0
);
CREATE TABLE HoaDon (
    hoa_don_id  SERIAL         PRIMARY KEY,
    ngay_tao    TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tong_tien   DECIMAL(14, 2) NOT NULL DEFAULT 0,
    customer_id INT            NOT NULL,
    CONSTRAINT fk_hoadon_khachhang
        FOREIGN KEY (customer_id)
        REFERENCES KhachHang(customer_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);
CREATE TABLE ChiTietHoaDon (
    ct_id                 SERIAL         PRIMARY KEY,
    hoa_don_id            INT            NOT NULL,
    product_id            INT            NOT NULL,
    so_luong              INT            NOT NULL CHECK (so_luong > 0),
    don_gia_tai_thoi_diem DECIMAL(12, 2) NOT NULL,
    CONSTRAINT fk_ct_hoadon
        FOREIGN KEY (hoa_don_id)
        REFERENCES HoaDon(hoa_don_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_ct_sanpham
        FOREIGN KEY (product_id)
        REFERENCES SanPham(product_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);
CREATE INDEX idx_hoadon_customer ON HoaDon(customer_id);
CREATE INDEX idx_ct_hoadon       ON ChiTietHoaDon(hoa_don_id);
CREATE INDEX idx_ct_sanpham      ON ChiTietHoaDon(product_id);