<?php
$url = "http://m.ibg.com/screen_data/api/module?idc=hk_5";
$data = file_get_contents($url);
echo json_encode($data);