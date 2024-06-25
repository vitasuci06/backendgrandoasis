<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
    <div class="row">
        <ol class="breadcrumb">
            <li><a href="#">
                    <em class="fa fa-home"></em>
                </a></li>
            <li class="active">Manage Rooms</li>
        </ol>
    </div><!--/.row-->

    <br>

    <div class="row">
        <div class="col-lg-12">
            <div id="success"></div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-body">
                    <?php
                    if (isset($_GET['error'])) {
                        echo "<div class='alert alert-danger'>
                                <span class='glyphicon glyphicon-info-sign'></span> &nbsp; Error on Delete !
                            </div>";
                    }
                    if (isset($_GET['success'])) {
                        echo "<div class='alert alert-success'>
                                <span class='glyphicon glyphicon-info-sign'></span> &nbsp; Successfully Delete !
                            </div>";
                    }
                    ?>
                    <table class="table table-striped table-bordered table-responsive" cellspacing="0" width="100%" id="rooms">
                        <thead class="text-uppercase">
                            <tr>
                                <TH>No</TH>
                                <th>Nama Tamu</th>
                                <th>Tipe kamar</th>
                                <th>No Kamar</th>
                                <th>Check in date</th>
                                <th>Check out date</th>
                                <th>status</th>
                                <th width="50px">action</th>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $room_query = "SELECT * FROM reservasikamar NATURAL JOIN tamu natural join kamar";
                            $rooms_result = mysqli_query($connection, $room_query);
                            // if (mysqli_num_rows($rooms_result) > 0) {
                            // if (!$rooms_result) {
                            //     die("Query failed: " . mysqli_error($connection));
                            // }
                            $no = 1;
                            while ($rooms = mysqli_fetch_assoc($rooms_result)) { ?>
                                <tr>
                                    <td width='50' class='center'><?= $no ?></td>
                                    <td><?php echo $rooms['FirstName'] ?></td>
                                    <td><?php echo $rooms['Tipe_kamar'] ?></td>
                                    <td><?php echo $rooms['Nomor_kamar'] ?></td>
                                    <td><?php echo $rooms['CheckInDate'] ?></td>
                                    <td><?php echo $rooms['CheckOutDate'] ?></td>

                                    <?php
                                        if ($rooms['Status'] ==  'Confirmed') {
                                            $status ='<a href="#" class="btn btn-primary"style="border-radius:0%">Confirmed</a>';
                                        }elseif($rooms['Status'] ==  'Booked'){
                                            $status ='<a href="#" class="btn btn-warning"style="border-radius:0%">Booked</a>';
                                        }elseif($rooms['Status'] ==  'Checked-Out'){
                                            $status ='<a href="#" class="btn btn-success"style="border-radius:0%">Checked-Out</a>';
                                        }else{
                                            $status = '';
                                        }
                                    ?>
                                    <td><?php echo $status ?></td>

                                    <td>

                                        <button title="Customer Information" style="border-radius:60px" data-toggle="modal" data-target="#cutomerDetailsModal" data-id="<?php echo $rooms['ReservasiKamar_id']; ?>" id="cutomerDetails" class="btn btn-info"><i class="fa fa-eye"></i></button>
                                        <!-- < ?php
                                                if ($rooms['status'] == 1) {
                                                    echo '<button title="Customer Information" data-toggle="modal" data-target="#cutomerDetailsModal" data-id="' . $rooms['room_id'] . '" id="cutomerDetails" class="btn btn-warning" style="border-radius:60px;"><i class="fa fa-eye"></i></button>';
                                                }
                                                ?> -->

                                        <!-- <a href="ajax.php?delete_room=<?php echo $rooms['room_id']; ?>" class="btn btn-danger" style="border-radius:60px;" onclick="return confirm('Are you Sure?')"><i class="fa fa-trash" alt="delete"></i></a> -->
                                    </td>

                                </tr>
                            <?php
                            $no++; }
                            // } else {
                            //     echo "No Rooms";
                            // }
                            ?>

                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>

    <!-- Add Room Modal -->

    <!--Edit Room Modal -->



    <!---customer details-->
    <div id="cutomerDetailsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title text-center"><b>Customer's Detail</b></h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <table class="table table-responsive table-bordered">
                                <!-- <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Detail</th>
                                </tr>
                                </thead> -->
                                <tbody>
                                    <tr>
                                        <td><b>NAMA TAMU</b></td>
                                        <td id="FirstName"></td>
                                    </tr>
                                    <tr>
                                        <td><b>TIPE KAMAR</b></td>
                                        <td id="Tipe_kamar"></td>
                                    </tr>
                                    <tr>
                                        <td><b>NOMOR KAMAR</b></td>
                                        <td id="Nomor_kamar"></td>
                                    </tr>
                                    <tr>
                                        <td><b>CHECKINDATE</b></td>
                                        <td id="CheckInDate"></td>
                                    </tr>
                                    <tr>
                                        <td><b>CHECKOUTDATE</b></td>
                                        <td id="CheckOutDate"></td>
                                    </tr>
                                    <tr>
                                        <td><b>STATUS</b></td>
                                        <td id="Status"></td>
                                    </tr>
                                    <tr>
                                        <td><b>HARGA</b></td>
                                        <td id="Harga"></td>
                                    </tr>
                                    <tr>
                                        <td><b>TANGGAL BAYAR</b></td>
                                        <td id="Tanggal_bayar"></td>
                                    </tr>
                                    <tr>
                                        <td><b>JUMLAH BAYAR</b></td>
                                        <td id="Jumlah_bayar"></td>
                                    </tr>
                                    <tr>
                                        <td><b>METODE BAYAR</b></td>
                                        <td id="Metode_bayar"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!---customer details ends here-->

    <!-- Check In Modal -->

    <!-- Check Out Modal-->


    <div class="row">
        <div class="col-sm-12">
            <p class="back-link">Developed By Prem Chand Saini</p>
        </div>
    </div>

</div> <!--/.main-->