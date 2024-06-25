
<div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
    <div class="profile-sidebar">
        <div class="profile-userpic">
            <img src="img/user.png" class="img-responsive" alt="">
        </div>
        <div class="profile-usertitle">
            <div class="profile-usertitle-name"><?php echo $user['Nama_admin']; ?></div>
            <div class="profile-usertitle-status"><span class="indicator label-success"></span><?php echo $user['Tipe_admin']; ?></div>
        </div>
        <div class="clear"></div>
    </div>
    <div class="divider"></div>
    <ul class="nav menu">
        <li <?php if (isset($_GET['dashboard'])) { echo 'class="active"'; } ?>>
            <a href="index.php?dashboard"><em class="fa fa-dashboard">&nbsp;</em> Dashboard</a>
        </li>

        <li class="parent <?php if (isset($_GET['room_mang']) || isset($_GET['reservasi_kamar']) || isset($_GET['reservasi_meeting']) || isset($_GET['reservasi_ballroom'])) { echo 'active'; } ?>">
            <a data-toggle="collapse" href="#sub-item-1">
                <em class="fa fa-bed">&nbsp;</em> Manage Rooms <span data-toggle="collapse" href="#sub-item-1" class="icon pull-right"><em class="fa fa-plus"></em></span>
            </a>
            <ul class="children collapse <?php if (isset($_GET['room_mang']) || isset($_GET['reservasi_kamar']) || isset($_GET['reservasi_meeting']) || isset($_GET['reservasi_ballroom'])) { echo 'in'; } ?>" id="sub-item-1">
                <li <?php if (isset($_GET['reservasi_kamar'])) { echo 'class="active"'; } ?>>
                    <a href="index.php?reservasi_kamar">
                        <span class="fa fa-arrow-right">&nbsp;</span> Reservasi Kamar
                    </a>
                </li>
                <li <?php if (isset($_GET['reservasi_meeting'])) { echo 'class="active"'; } ?>>
                    <a href="index.php?reservasi_meeting">
                        <span class="fa fa-arrow-right">&nbsp;</span> Reservasi Meeting Room
                    </a>
                </li>
                <li <?php if (isset($_GET['reservasi_ballroom'])) { echo 'class="active"'; } ?>>
                    <a href="index.php?reservasi_ballroom">
                        <span class="fa fa-arrow-right">&nbsp;</span> Reservasi Ballroom
                    </a>
                </li>
            </ul>
        </li>

        <li <?php if (isset($_GET['staff_mang'])) { echo 'class="active"'; } ?>>
            <a href="index.php?staff_mang"><em class="fa fa-users">&nbsp;</em> Staff Section</a>
        </li>
    </ul>
</div><!--/.sidebar-->
