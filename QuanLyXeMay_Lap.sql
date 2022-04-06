-- Họ tên: Lục Văn Lập
-- Lớp:TH25.07

-- Tạo cơ sở dữ liệu
create database QuanLyXeMay
-- Chọn cơ sở dữ liệu
use QuanLyXeMay

-- Tạo bảng xe máy
create table XeMay( 
	MaXe char(10) not null primary key,
	TenXe char(10) not null,
	MauSac nvarchar(10) not null,
	PhanKhoi int not null,
	GiaNhapXe money not null,
	GiaBan money not null,
	MaNSX char(10) not null,
	SoLuongNhap char(10) not null,
	NgayNhap datetime not null
)

-- Tạo bảng nhà sản xuất
create table NhaSanXuat(
	MaNSX char(10) not null primary key,
	TenNSX nvarchar(50) not null,
	DiaChi nvarchar(50) not null
)

-- Tạo bảng khách hàng
create table KhachHang(
	MaKH char(10) not null primary key,
	HoTen nvarchar(50) not null,
	DiaChi nvarchar(50) not null,
	SDT char(10) not null
)

-- Tạo bảng đơn hàng
create table DonHang(
	MaHD char(10) not null primary key,
	MaKH char(10) not null,
	NgayLapHD datetime not null
)

-- Tạo bảng ct đơn hàng
create table CTDonHang(
	MaHD char(10) not null,
	MaHang char(10) not null,
	SoLuongBan char(10) not null,
	NgayGiao datetime not null
)

-- Tạo các khóa ngoại bảng xe máy
alter table XeMay add constraint a_MaNSX foreign key(MaNSX) references NhaSanXuat(MaNSX) 
on update cascade 
on delete cascade;

-- Tạo các khóa ngoại bảng đơn hàng
alter table DonHang add constraint a_MaKH foreign key(MaKH) references KhachHang(MaKH) 
on update cascade 
on delete cascade;

-- Tạo các khóa ngoại ct đơn hàng
alter table CTDonHang add constraint a_MaHD foreign key(MaHD) references DonHang(MaHD) 
on update cascade 
on delete cascade;

-- Nhập dữ liệu vào bảng
-- Bảng nhà sản xuất
insert into NhaSanXuat values
('NSX01', 'Suzuki', N'Hà Nội'),
('NSX02', 'HonDa', N'Hà Nội'),
('NSX03', 'Yamaha', N'Bắc Ninh'),
('NSX04', 'Sym', N'Đà Nẵng'),
('NSX05', 'Kawasaki', N'Bắc Giang')

-- Bảng xe máy
insert into XeMay values
('XM08', 'honda lou', N'Bạc', 125, 22000, 28000, 'NSX02', '110', '2020/01/30'),
('XM07', 'honda lead', N'Bạc', 110, 21000, 25000, 'NSX02', '100', '2020/01/19'),
('XM06', 'Vision 1', N'Trắng', 100, 20000, 25000, 'NSX02', '100', '2020/01/19'),
('XM01', 'Honda 29', N'Đen', 100, 20000, 25000, 'NSX02', '100', '2020/01/19'),
('XM02', 'Suzuki z9', N'Trắng', 100, 30000, 45000, 'NSX01', '200', '2022/04/10'),
('XM03', 'Kawasaki z', N'Tím', 50, 24000, 30000, 'NSX05', '400', '2021/11/09'),
('XM04', 'Yamaha hui', N'Nâu', 130, 18000, 25000, 'NSX03', '50', '2020/03/12'),
('XM05', 'Sym baka', N'Xanh', 100, 22000, 26000, 'NSX04', '100', '2022/10/02')

-- Bảng khách hàng
insert into KhachHang values
('KH06', N'Nguyễn Văn Khải', N'Hưng Yên', '03462237'),
('KH01', N'Nguyễn Kim Hoa', N'Hà Nội', '0346237'),
('KH02', N'Vũ Thị Thoa', N'Bắc Ninh', '03463445'),
('KH03', N'Đào Văn Hồng', N'Hà Nội', '03462235'),
('KH04', N'Chu Văn Đức', N'Hà Nội', '03462341'),
('KH05', N'Bảo Khánh', N'Bắc Giang', '034623432')

-- Bảng đơn hàng
insert into DonHang values
('HD06', 'KH05', '2021/05/21'),
('HD01', 'KH02', '2022/03/03'),
('HD02', 'KH03', '2022/02/23'),
('HD03', 'KH01', '2022/10/01'),
('HD04', 'KH05', '2020/09/09'),
('HD05', 'KH04', '2021/12/13')

-- Bảng xe máy
insert into CTDonHang values
('HD05', 'H06', '', '2022/01/03'),
('HD01', 'H01', '20', '2022/03/03'),
('HD02', 'H03', '12' , '2022/02/23'),
('HD03', 'H02', '30', '2022/10/01'),
('HD04', 'H04', '40', '2020/09/09'),
('HD05', 'H05', '23', '2021/12/13')


--Phần 1 :Tạo các ràng buôc sau bằng (check,unique,trigger)
--1.	Tên xe,tên nhà sản xuất là duy nhất 
alter table XeMay
add constraint s_Ten unique (TenXe)

alter table NhaSanXuat
add constraint s_TenNSX unique (TenNSX)

--2.	Số lượng nhập xe là từ 20 cái trở lên
alter table XeMay
ADD CHECK(SoLuongNhap > 20)

--3.	Ngày bán xe > Ngày Nhập

--4.	Giá bán xe từ 20.000 đến 90.000
alter table XeMay
ADD CHECK(GiaBan Between 20000 and 90000)

--5.	Ngày Lập hóa đơn từ ngày 1/1/2021 trở đi 
alter table DonHang
ADD CHECK(NgayLapHD > 1/1/2021);

--6.	Phân khối xe chỉ được nhập một trong các giá trị sau : 110,125,150
 CREATE TRIGGER a_PhanPhoi on XeMay
 for insert,update
 as
   if exists (select * from inserted inner join XeMay on
   inserted.PhanKhoi=XeMay.PhanKhoi
   where (inserted.PhanKhoi not in ( 110,125,150)
   begin
		print N'Phân khối xe chỉ được nhập một trong các giá trị sau : 110,125,150'
		rollback tran

	end

--7.	Tên nhà sản xuất chỉ được nhập các nhà sản xuất (HonDa,Suzuki,Yamaha)
 CREATE TRIGGER b_NhaSanXuat on NhaSanXuat
 for insert,update
 as
   if exists (select * from inserted inner join NhaSanXuat on
   inserted.TenNSX=NhaSanXuat.TenNSX
   where (inserted.TenNSX not in (HonDa,Suzuki,Yamaha)
   begin
		print N'Tên nhà sản xuất chỉ được nhập các nhà sản xuất (HonDa,Suzuki,Yamaha)'
		rollback tran

	end

--Phần 2 : tạo các truy vấn sau 
--1.	Đưa toàn bộ thông tin xe hiện có 
select *from XeMay

--2.	Liệt kê ra danh sách các xe có giá bán lớn hơn giá bán của xe vision màu trắng. ?
select *from XeMay
where GiaBan > 20000

--3.	Liệt kê ra tên các nhà sản xuất  có bán mặt ít nhất 1 chiếc xe có màu đen
select * from NhaSanXuat
select TenNSX 
from NhaSanXuat a inner join XeMay  b on a.MaNSX = b.MaNSX
where MauSac = N'Đen'
group by TenNSX

--4.	Đưa ra danh sách các xe chưa bán được chiếc nào 
select * from CTDonHang
where SoLuongBan = ''

--5.	Đưa ra danh sách các xe có cùng màu với xe honda lead màu bạc và phân khối  lớn hơn?
select TenXe
from XeMay
where MauSac = N'Bạc' and PhanKhoi > 110

--6.	Đưa ra danh sách các mặt hàng có giá bán lớn hơn hoặc bằng 10% giá mua?
select TenXe
from XeMay
where GiaBan >= (GiaNhapXe/100 *0.1) 
--7.	Đưa ra danh sách các loại xe máy màu đỏ hoặc các loại xe máy có giá bán nằm trong khoảng từ 25 đến 35 triệu đồng?
select TenXe
from XeMay
where MauSac = N'đỏ' or (GiaBan between 25000 and 35000)

--8.	Đưa ra tên và giá mua của xe có giá mua đắt nhất?
select top 1 TenXe, max(GiaBan) as Giacaonhat
from XeMay
group by TenXe, GiaBan

--9.	Liệt kê khách hàng có địa chỉ ở 'Hưng Yên'
select * from KhachHang
where DiaChi = N'Hưng Yên' 

--10.	Liệt kê hóa đơn bán hàng trong tháng 5 năm 2021
select * from DonHang
where MONTH(NgayLapHD) = 05 and YEAR(NgayLapHD) = 2021

--11.	Cho biết tên các xe đã bán và với mỗi xethì cho biết giá bán trung bình, tổng số lượng đã được bán. Kết quả sắp xếp theo chiều giảm dần của tổng số lượng bán?

--12.	 Đưa ra các thông tin sau : MaHang,TenHang,SoLuongMua,GiaBan, ThanhTien=SoLuong*GiaBan,  nếu số lượng xe mua >10. Thì giảm giá 10%, còn lại không giảm
select MaXe,TenXe,SoLuongNhap,GiaBan, ThanhTien=SoLuongNhap*GiaBan
from XeMay 


--13.	Đếm số lượng xe máy của nhà sản xuất honda
select count(MaXe) as SoLuongXe
from XeMay --a inner join NhaSanXuat b on a.MaNSX = b.MaNSX
where MaNSX = 'NSX02'
--14.	Tính tổng tiền bán được của  các hóa đơn trong tháng 3/2021

--15.	Liệt kê các xe đã bán vào ngày 8/3/2021


-- Phần 3:Tạo các view hiển thị thông tin sau :
-- 1.	Đưa ra các thông tin sau : MaXe,TenXe,mau,PhanKhoi,TenNSX,SoLuongMua,GiaBan, ThanhTien=SoLuong*GiaBan
Create View ThongTin 
as
select MaXe,TenXe, MauSac,PhanKhoi,MaNSX,SoLuongNhap,GiaBan, ThanhTien=SoLuongNhap*GiaBan
from XeMay

-- 2.	Hiển thông tin các đơn đặt hàng bao gồm : MaHD,MaKH,NgayLapHD,NgayGiao,SoluongBan
Create View ThongTinDatHang 
as
select DonHang.MaHD,MaKH,NgayLapHD,NgayGiao,SoLuongBan
from CTDonHang, DonHang

-- 3.	Hiển thị các xe đã bán vào ngày 8/3/2021


