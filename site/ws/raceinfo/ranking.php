<?
    include_once("config.php");
    include_once("wslib.php");

    header("content-type: text/plain; charset=UTF-8");

    //FIXME : types are badly checked
    $ws = new WSBaseRace();
    $now = time();
    
    $ws->require_idr();
    $races = new races($ws->idr);
    
    $query_ranking = "SELECT RR.idusers idusers, US.username boatpseudo, US.boatname boatname, US.color color, US.country country, nwp, dnm, userdeptime as deptime, RR.loch loch, US.releasetime releasetime, US.pilotmode pim, US.pilotparameter pip, latitude, longitude, last1h, last3h, last24h " . 
      " FROM  races_ranking RR, users US " . 
      " WHERE RR.idusers = US.idusers " . 
      " AND   RR.idraces = "  . $races->idraces .
      " ORDER BY nwp desc, dnm asc";

    $res = $ws->queryRead($query_ranking);

    $ws->answer['request'] = Array('idr' => $ws->idr, 'time' => $now);
    $ws->answer['ranking'] = Array();
    
    while ($row = mysql_fetch_assoc($res)) {
        // N'entrent dans les tableaux que les bateaux effectivement en course
        if ( !array_key_exists('nwp',$row) || ($row['dnm'] == 0.0) && ($row['loch'] == 0.0)) continue;
        // Calcul du status
        if ( $row['releasetime'] > $now ) {
            $row['status'] = 'locked';
        } else if ( $row['pim'] == 2 && abs($row['pip']) <= 1 ) {
            $row['status'] = 'on_coast';
        } else {
            $row['status'] = 'sailing';
        }
        unset($row['pim']);
        unset($row['pip']);
        $row['latitude'] /= 1000.;
        $row['longitude'] /= 1000.;
        $ws->answer['ranking'][$row['idusers']] = $row;
    }

    list ($num_arrived , $num_racing, $num_engaged) = getNumOpponents($races->idraces);    
    $ws->answer['nb_arrived'] = $num_arrived;
    $ws->answer['nb_racing'] = $num_racing;
    $ws->answer['nb_engaged'] = $num_engaged;

    $ws->reply_with_success();

?>
