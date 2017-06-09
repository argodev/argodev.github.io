---
layout: post
category: personal
title: 'Grand Canyon Trip - Overview'
date: 2017-05-30 17:47
tags:
- vacation
- road trip
description: "My wife and I have sketched out three \"big trips\" that represent experiences we want to have as a family before our kids head off to college. Given our family of six, traveling can be expensive which means we end up planning for each trip for 2-3 years before it happens. The first of these is getting ready to kick off tomorrow and I am incredibly excited - we have been planning for this trip for just over two years."
---

My wife and I have sketched out three "big trips" that represent experiences we want to have as a family before our kids head off to college. Given our family of six, traveling can be expensive which means we end up planning for each trip for 2-3 years before it happens. The first of these is getting ready to kick off tomorrow and I am incredibly excited - we have been planning for this trip for just over two years. Tomorrow we will load everyone into our car and head out for a 16-day road trip that will depart from Knoxville, TN and take us to the Grand Canyon and 37 other (planned) destinations before arriving home. We expect to travel nearly 4,700 miles over these next few days with nearly 80 hours of driving.

In order to help maintain a semblance of sanity while in the car, as well as to help the kids build lasting memories, my wife and daughter assembled notebooks/journals for each kid that, along with activity sheets, has a page to complete each day which prompts them to record their memories, include any pictures, thoughts, etc. This web page (and those linked) are my attempt at my version of a journal. Being a bit on the techy side, my goal is to include some pictures, as well as an interactive maps of our route and stops. The primary purpose for this journal is our family memories as well as being able to share with extended family and friends.

### Adgenda
- [Day 1: Big Driving Day]({{ site.baseurl }}{% post_url 2017-05-31-gctrip-day01 %})
- [Day 2: Beach Day!]({{ site.baseurl }}{% post_url 2017-06-01-gctrip-day02 %})
- [Day 3: Swamp Visit/Afternoon Drive]({{ site.baseurl }}{% post_url 2017-06-02-gctrip-day03 %})
- [Day 4: The Alamo!]({{ site.baseurl }}{% post_url 2017-06-03-gctrip-day04 %})
- [Day 5: Long Drive Day]({{ site.baseurl }}{% post_url 2017-06-04-gctrip-day05 %})
- [Day 6: Carlsbad Caverns]({{ site.baseurl }}{% post_url 2017-06-05-gctrip-day06 %})
- [Day 7: Very Large Array (Another Drive Day)]({{ site.baseurl }}{% post_url 2017-06-06-gctrip-day07 %})
- [Day 8: Petrified Forest]({{ site.baseurl }}{% post_url 2017-06-07-gctrip-day08 %})
- [Day 9: Grand Canyon Day!]({{ site.baseurl }}{% post_url 2017-06-08-gctrip-day09 %})
- Day 10: Horsehoe Bend/Monument Valley
- Day 11: National Museum of Nuclear Science
- Day 12: Cadillac Ranch!
- Day 13: VW Bug Ranch
- Day 14: USS Batfish Museum
- Day 15: Ft. Smith Historic Site
- Day 16: Home!

### Route Overview

<div id="map"></div>
{% raw %}
<script>
    var stops = [
        {name: 'Home', lat: 35.9586595, lon: -84.065509},
        {name: 'SpringHill Suites', lat: 30.6816292, lon: -88.131592},
        {name: 'Biloxi Beach', lat: 30.394054, lon: -88.901379},
        {name: 'Lunar Lander Exhibit', lat: 30.313457, lon: -89.600074},
        {name: 'Old US Mint', lat: 29.961821, lon: -90.057811},
        {name: 'Sleep Inn and Suites', lat: 30.0009959, lon: -90.1886205},
        {name: 'Cajun Pride Swamp Tours', lat: 30.095049, lon: -90.4385764},
        {name: 'SpringHill Suites', lat: 29.6262022, lon: -95.6005171},
        {name: 'The Alamo', lat: 29.4259718, lon: -98.4883359},
        {name: 'San Antonio River Walk', lat: 29.423754, lon: -98.4866138 },
        {name: 'SpringHill Suites', lat: 29.615672, lon: -98.598078},
        {name: 'Fairfield Inn and Suites', lat: 32.391971, lon: -104.2230587},
        {name: 'Carlsbad Caverns National Park', lat: 32.122342, lon: -104.6034896},
        {name: 'White Sands National Monument', lat: 32.7872448, lon: -106.3278756},
        {name: 'Quality Inn', lat: 32.8773207, lon: -105.9613014},
        {name: 'The Very Large Array - Visitors Center', lat: 34.0758546, lon: -107.6226157},
        {name: 'Comfort Inn', lat: 34.9353902, lon: -110.1352302},
        {name: 'Petrified Forest National Park', lat: 34.9849849, lon: -109.9189539},
        {name: 'The Grand Canyon Railway Hotel', lat: 35.2519747, lon: -112.1936513},
        {name: 'Grand Canyon National Park', lat: 36.057523, lon: -112.135626},
        {name: 'Horseshoe Bend', lat: 36.8791631, lon: -111.512707},
        {name: 'Monument Valley', lat: 36.9980328, lon: -110.1006514},
        {name: 'TownePlace Suites', lat: 36.7669695, lon: -108.1467596},
        {name: 'National Museum of Nuclear Science & History', lat: 35.0659899, lon: -106.5360859},
        {name: 'TownePlace Suites', lat: 35.0591628, lon: -106.6220605},
        {name: 'Route 66 Auto Museum', lat: 34.9462409, lon: -104.6566946},
        {name: 'Russells Truck & Travel Center and Free Museum', lat: 35.1753441, lon: -103.1062639},
        {name: 'Cadillac Ranch', lat: 35.1890484, lon: -101.989501},
        {name: 'Fairfield Inn & Suites', lat: 35.1942548, lon: -101.7282028},
        {name: 'VW Slug Bug Ranch', lat: 35.2155488, lon: -101.3860163},
        {name: 'Tower Station and U-Drop Inn Café', lat: 35.2267144, lon: -100.2507983},
        {name: 'SpringHill Suites', lat: 35.6105613, lon: -97.5766786},
        {name: 'POPS Soda Ranch', lat: 35.6582813, lon: -97.337674},
        {name: 'USS Batfish Military Museum', lat: 35.7937827, lon: -95.3127712},
        {name: 'Fairfield Inn and Suites', lat: 36.0299458, lon: -95.8659799},
        {name: 'Fort Smith National Historic Site', lat: 35.388307, lon: -94.4319587},
        {name: 'SpringHill Suites', lat: 35.1459944, lon: -90.0549883}
    ];

    var encoded_route = "wjezEbnaaOtb@j{@~c@ds@nq@nYpa@gO`]yl@le@nGrTng@nUrn@bb@d[`m@dSpg@xe@lq@nRxq@bTfi@he@bZnb@d`@dj@fc@ln@vc@|n@jc@vn@ja@~p@h]tt@f]bu@|c@tm@nh@lh@fh@hh@xf@fj@|b@do@bi@j`@tj@zc@vi@ze@li@pf@xe@rk@ze@xk@bk@jc@vl@|_@`m@z_@vj@ld@nj@nd@hk@lc@xl@b`@zl@``@|l@``@rk@pb@zi@|e@ld@lm@`f@jk@ze@hk@vg@ji@bh@|g@vi@ff@`j@be@hh@dh@jh@nh@bh@nh@`h@lh@bh@`h@bh@jh@`g@ri@dh@th@`h@fh@fh@fh@di@vg@hh@~g@`h@jh@bh@fh@jh@hh@hh@ph@`h@fh@`h@lh@lh@nh@`h@hh@zf@hj@te@tk@hh@lh@dh@dh@re@je@xh@ra@jl@la@fi@lf@`j@he@bh@|h@fh@`h@vl@v_@to@lYtp@dUjm@f_@fo@r[lp@nV|m@`]zZpu@vJt~@xLt}@~]ps@b`@~q@rm@xZnq@dTpp@|Tbq@lUrm@p^`m@~_@rl@l_@bn@p]bm@f_@xl@b`@vl@d`@xm@t]bm@x_@jm@b`@zk@ba@~^hr@tY`x@tYfx@~^fr@`e@hl@`e@dl@je@rl@vd@~k@~_@dr@~S`u@fLv|@~K|}@~Lt}@d^bs@vb@dm@lNpk@dKxn@xAhz@jBn~@l]hi@~k@b[~p@rUzp@bVvm@z\\d\\rs@|Rtz@xN`}@pNf|@bOt}@hWdz@t`@`r@ri@fe@l_@~r@|]ns@ld@~l@hf@vi@dg@bk@|j@rb@fl@~\\`Z|m@fPl}@rOn|@|Gf}@h@bs@{O~t@iRds@uRhr@u^nk@iJnn@pb@zc@{Fnp@qNpu@eIlt@wb@bj@iVtv@oLjr@fm@dZlb@tf@cWht@i_@xq@{Ft{@fLdx@vKxw@z^pg@vd@tc@`d@td@li@vPbo@vTzj@zb@nb@fi@`d@hf@za@nl@tEp|@_Vhv@v\\xl@|d@td@xm@fa@pf@ri@`e@dl@vh@te@ps@yFbs@{Hjn@l[|f@bi@lm@|_@rk@za@fh@pg@vo@`Zfr@bP|l@h]nk@~a@rp@bW~q@rP~r@`Nnm@p\\`m@j_@~p@vRns@qBzm@q^dr@yMns@eFnq@sOrs@fArt@[pt@[pr@bJ~h@tf@rk@pb@ri@ja@rZjWxd@bb@th@|e@~g@fe@~h@ve@lj@lc@fj@jc@dj@pc@tk@``@bm@~]dm@z]pk@j`@lj@~b@lo@rXjq@lQjq@jQtm@zZph@rf@di@fd@fj@~a@`k@fc@rl@fd@bi@bj@pi@th@ts@vQbv@`Ejv@bEpv@hEru@bIrn@~_@tk@jf@tk@pf@xk@bf@nk@nf@fl@ne@xl@pd@|j@xg@~d@`o@re@`o@ni@hi@vk@jf@zk@~e@zn@p`@bp@v]dp@z]hp@t\\rp@b\\li@pi@pi@bi@rm@nc@`n@ra@bn@va@~i@xh@fi@|i@|j@rg@zo@l^tn@p`@bk@vf@~n@f`@lp@p\\jh@jk@nh@hk@~h@lj@nk@hf@bq@n[fq@`[zp@v[hf@pm@ng@nl@vj@tg@hm@lc@pm@pc@pl@pd@fl@he@pj@tg@`m@zc@bm@b^zn@f`@|q@fN|e@ke@xq@yV`i@vc@pk@~l@~h@pm@tk@hi@tm@xf@hl@xg@pp@t`@zm@le@dl@rg@de@lp@x\\~x@x_@tv@nd@jq@ts@jS~t@iQds@|R~k@rf@|n@~b@`n@be@`j@zj@ta@~t@`a@nu@ha@ju@l`@vu@|]`x@l\\by@pUl}@hUn}@~Rx~@t_@fv@hd@nr@td@zq@ri@zk@vk@th@nh@lm@zb@rs@ra@~t@lb@`t@de@dj@ho@t_Af]~m@zZbv@tZ|u@hY`w@|`@tp@bf@~j@ff@`k@~e@~j@bf@bk@df@|j@bd@`m@d`@zq@b`@jq@pa@jp@z^dr@zQb{@xOj|@bP|{@zO~{@zKd|@lIt|@~Jl_Afa@~o@|e@|j@pk@bb@fn@n]fn@j]|l@t`@p]rs@v^dr@dl@xa@~p@zVbq@jWnp@nWzh@pf@ld@bm@pa@|o@v\\lt@jUnx@~Ar_AnIp~@x[pt@x`@dq@te@dk@hg@hi@fg@bi@rj@`e@hk@f[bl@~^tf@te@xf@fUfd@sh@bp@gZ`q@_X`t@dAxs@nI`t@hIht@`J|l@t`@v^tr@|\\~s@p[lu@h]zs@la@ro@`c@jo@~l@|`@zn@h^vq@uIns@wDtn@t\\vm@`_@ni@bf@`f@`k@~e@bk@bi@rf@pi@lf@pi@nf@~j@fc@hb@~n@t_@lr@|\\hl@tm@gHjs@gMnr@}S|r@}A|q@dPlp@rClr@}Cns@fChj@zc@du@x@ho@tWzl@~^nm@|Vfs@tD~q@gEpo@cArr@cAbt@jDls@vK|n@~]|r@Bxo@}Ztk@cb@xi@uc@ro@mY~r@sPrq@mTjq@aUfp@uXho@yZxb@gn@z_@yq@tf@uh@dr@{Qlt@aFjt@gFlt@iFht@gFbt@iGfr@mQfm@cQxo@}Mfr@aEjt@mE~s@uGnp@eXfp@iY`p@gY~m@{\\xk@ib@bm@c_@vl@a`@|m@m^xm@u^tm@o^zm@m^jo@aZzp@oVfn@m]pi@ue@xi@me@zi@we@|l@w_@vm@o^pm@i^lm@m^|k@o^~i@m`@|j@ea@nn@o]|q@mSlr@qQtr@wQfr@yQnr@mQ|r@oQbr@mQnr@uQdq@iUho@mZpm@e_@bm@u_@~l@q_@zl@y^|m@g^fn@a^pn@i[ho@k[|n@{Z`q@eWbq@yUfq@aV~p@oXtp@sXdp@kXhq@aT`m@{Nbl@kIfr@mObn@y\\do@s\\pt@kGxs@qJlp@cWpp@cWrr@oP~r@qO~q@aRph@{f@|i@_e@dq@uVpq@}Tze@_k@tc@ql@ni@af@xm@c^hm@a_@zi@cd@|j@id@nm@w_@~n@i]`o@w]xn@_]bn@y\\`m@q]dj@ed@n`@ud@bb@}h@xc@wj@vd@el@|d@}k@|h@ae@nt@yA|s@zBxt@aDnt@oBpl@lPlg@p]`n@lYdo@zNrq@`Fhl@hBvq@zCjr@pKlq@hTtn@|[hl@f_@nl@p_@tk@~a@zj@fc@xj@rc@vh@`g@df@zi@ve@rj@ve@tj@`i@ff@`m@f_@hp@zWfj@hVhk@~a@~n@xZ~s@tKht@pKrr@pSvp@rXtq@vVnq@`Wvi@p]l_@~b@hCmCnZnZlo@x_@fu@dXxq@hYtr@vZ~r@|[~n@rf@~i@hj@|t@~]nx@hPbq@|_@tr@rZbt@dVnv@pNlu@lN`t@lYpv@nUts@tVfi@lj@bg@bm@lf@~k@rk@~c@~o@`c@`o@jb@lo@hd@|k@pi@rk@fj@hp@xe@tp@va@bo@rc@zj@tg@bj@`g@zi@ji@~c@`r@~e@`q@jl@nh@dp@ja@|u@jMzv@pKns@jT~r@`Vfq@j\\`j@~j@ti@tn@jm@ti@du@z\\dv@~[ft@~^rs@la@|r@`a@rq@lc@pp@je@zt@za@ht@r`@hu@x_@ru@v_@|t@n_@jo@vh@jk@~k@tk@jl@fk@tk@xj@dk@hj@fk@bk@zk@lk@|k@ll@|h@lo@|e@ho@nf@fj@zj@xh@vn@lh@~m@hh@`n@dh@rm@dh@fn@ni@do@xj@tm@|k@nk@xk@`k@nl@|k@jl@zk@vm@fj@nn@`g@jj@nc@~k@xd@`m@df@`m@te@nm@jf@hj@dl@xf@pn@bg@fo@nf@~k@pi@df@xk@ve@zl@|f@`m@rg@bm@`g@`i@th@ze@no@xd@xo@je@hp@~`@hr@fZhz@pYx{@pYb{@~Wbx@v^|v@f`@~u@ja@tw@ha@lw@f`@tu@r_@ft@fc@tu@je@lq@hd@ro@za@rl@`a@tk@xd@lp@`e@zp@vd@rp@|d@xp@fa@dt@l]zw@j]vw@v\\vv@l]|w@lb@tt@~g@no@xg@do@lh@~o@|g@jo@`h@do@ng@xn@~f@bn@za@bs@rYfu@zXdu@tYpv@lX|s@lWvq@pY|v@j[xy@~Zxx@nZxx@zZby@f_@hw@de@lq@t[tw@fPd~@tNd|@fOz}@~Oj}@b[rv@vb@br@tc@ps@~c@~s@jc@ps@fb@zq@zY|y@zR~{@t]zw@fb@bt@b^hy@fVrx@|Pjx@zRxy@v`@rv@fd@|t@na@fq@|^jr@f]pt@|b@vn@rb@tm@`b@lo@lf@hu@xc@~x@pZt|@nUn`AvTt~@|P`_AhLdaAjLhaAfKbcApD`dA~HxcAfN`cAbJt`Ar@zw@rDb{@rOp}@tP|`AvOx}@lPp`AfPj_AzOn}@pOr|@fOp{@fQx~@h[vw@h]lu@n[br@nUry@fKzaArJx_AfTny@~d@xq@ha@vs@|_@nv@p_@hu@l_@~t@~_@`v@b_@`t@`k@hg@tt@hUbq@p\\zl@fb@xk@ha@bo@|c@~q@h`@bu@rHtu@_Lrt@sP`t@uPft@sPbs@uGro@rUhe@hg@fb@dh@t[xk@`e@jVfl@fAtl@dB`i@pGng@pG~f@jGle@nNzQxi@lIbKeEEqAyc@bWeFlVuDzGpb@K`l@?ak@}M}h@}s@Q`Rs@vo@\\jp@Gno@{Efo@eSbn@}Shs@gE~o@zHzdArcBvf@bf@th@nc@jl@`]hm@b[he@nh@tZzt@h\\`s@ja@do@xa@ln@|a@rn@ja@fo@n`@~o@t[vs@nYdu@tYfu@rYdu@x\\`s@p]lr@l\\js@d[|s@dWvv@jVhw@bRdy@zKt{@~Jx{@~Jx{@jKt{@|Pvy@`Vjw@bVdw@nVhw@hVzv@jTtq@lVbw@nVfw@bQly@xFr|@tFx|@fDx|@|Ad}@zAh}@nC~|@vShx@|Vvv@fWtv@fVbw@zHd|@|Fv|@p@~|@Lp}@Jf{@Nly@Jh}@Nb}@Pt}@T~|@nDd}@fEd{@i@~r@ag@|L}Yba@q\\r`@ad@bZ_\\xb@iXxh@y]ja@e^j]i]x\\ma@|`@lRx\\xc@lS~e@zR|g@`Gzi@wAzd@cA|k@cCbc@pCmFxc@lVzg@~Yt`@dXbb@lLnj@tLde@pL~c@xOpl@xNdi@`Ulh@yGfu@cGvq@mEzi@Jfx@`@fq@`@t|@hQle@lc@z`@vc@n`@he@nb@lPrf@w@lz@iC|aA_@rw@wDzu@|Be`@ai@hCgn@uCun@U_l@lAwm@fAgm@Hol@Lmi@vBoHfHdOhp@lNpn@|Dhx@yFrz@sTxw@y\\`t@qUjw@i@r}@fAv}@zW~u@z^tq@vK|{@dHh}@`K|{@lJl|@fHx|@dHx|@fH||@lHz|@rN|z@`O~z@rMzu@bNnz@|Ml{@nHp|@Lz}@bKb|@jLx{@hLx{@`Df}@Nr}@xCl}@rTlx@vTnx@nTvx@lMd{@t@r}@Dx}@gAt}@q@l}@tGz|@~G~|@tMb{@|\\hs@d\\zs@|Q~y@fQry@~Pbz@lQ~y@dQ`z@dQfz@fQ`z@nQzy@jQhz@nP`z@bPxu@bQjz@bQ`z@vPjz@bNf{@hNb{@`Nf{@xMl{@bNf{@bNf{@~Mj{@gBv|@}Bx|@jPnz@bQdz@fQdz@nPrx@~Opv@hJzp@tPcCzO}@NnOsAm`@a]|`@zPpj@jPhw@hQdx@xPnz@fLpx@fLj{@jL`{@fJjy@Fh|@iAj|@eA|z@uA~y@mK|y@eOry@}Ipz@lb@`f@lq@tQdq@zQbq@tQvp@pQjq@xQ`q@tQbp@lQnm@`Z`f@je@de@ng@~e@hh@hi@~e@be@de@xe@`h@~d@bg@hf@ph@te@~g@jg@pi@xg@`j@bg@li@hc@tj@ve@|f@vh@~`@rh@l`@tj@~a@vh@fc@ff@bb@nh@|c@bh@tc@bh@rc@hh@xc@nh@~c@dNfh@f\\s_@lb@xQ|`@v\\jj@nRjk@eAj]|l@eh@~Cqk@{AUd\\|Xbe@pTda@vVfd@|Xzg@vWjf@jRbi@hSbq@bPbi@vJbn@rGvp@x]fWvi@eCtg@rFbLnj@hKjt@hHrj@pVte@r\\zZh`@p[n`@tL`Xt]|\\`^p^wC`^gLmHs^ag@|Aei@hBwj@`Cma@lJhCjq@{Hdn@sA`o@oCnq@yE~q@gBzq@gBvp@{A`n@kApo@eApn@sA~|@{@jp@cAbo@wAvo@mFj|@kNvUkJfw@cL|Fa@|q@{Evo@eDzl@gBnq@iBjr@qA`q@~B~p@bCns@bCjt@bC~s@xBvs@uBtr@sMlr@yXjn@o\\jj@k\\dj@g\\`j@w\\hk@o\\nj@g]jk@{\\`k@q\\rj@{\\jk@w[hi@q\\rj@}[vi@o[di@uWhj@yMlr@yNhv@aO`x@iQbn@md@qQjItBdUhl@gK`n@cKjj@{Ltn@uMto@}Obs@gPlt@uPdv@uHfx@cDbz@iDfz@uDzz@kDxz@mDvz@yCzz@kDzz@iDxz@kDzz@kDzz@iDvz@kDzz@kDp|@qDr{@kDj{@oDj|@mDl{@eDhy@{C|s@sIfz@kP`z@uPfy@wOhv@kObu@iPdx@wPty@qPby@cPhx@qKfz@iHzz@cHvx@{Gzx@wJn|@_Pp|@{Ot|@yOx|@{Ot|@}Ov|@uTtz@cZrw@sZjw@mZhw@aZtw@mZrw@wY~u@m_@rm@}g@fc@ci@va@{i@lb@{i@ra@ok@xZyj@jW}j@hWyl@lXwo@vXes@`Rav@fJcv@rH_v@dIqs@|Ssl@xc@sh@ti@yh@ti@oh@xi@yj@rf@ql@hd@_l@vc@}k@nc@gi@vh@m`@tq@g`@hr@c`@nr@c_@hp@{d@|m@oc@dn@yc@bl@g^nl@gRjs@uGfw@iEdx@yDvv@wDxw@cKlw@i\\df@wf@xRwD`n@aAru@aBnu@eBdv@iIbz@kTh|@wGj_AwMt}@eNd}@sKp}@xAt`AzBn`A~BhbA|BraAxGh_AbOp{@hOh|@~Nj{@`O`{@nNtx@~Nb{@nOx|@fPn}@~Tv{@fTh{@dPt~@nOx|@nOf}@zKx~@hJv_AhOt~@|Or}@~Ndz@pNlz@hNxw@dNdw@bNdw@rM~t@tM`u@vMxu@lMlt@nMpt@rMfu@lMlt@lMht@`Nlv@lN~w@hOxv@bNdv@pMly@fNvw@jOd|@|Nvy@lNvw@fNnv@`Obz@rOpx@Z|e@vI_NeIbB`Ofh@vLhq@tMfu@hMrs@tLvp@zMlu@tM~t@xM~t@vMvv@xItz@`Lb{@~Lzz@jI|{@`It{@fJv{@xKf{@|Lxz@pO|y@nO~y@nO~y@`Nzt@dKxj@nMhn@~T|m@bV~m@jU`r@dPlv@hPfw@|Pry@xPfy@~Pny@fQhy@vUfw@`Vzv@rUdw@|Udw@dPhy@bBr|@M||@Kx|@Mz|@K~|@K||@E||@S||@Mz|@I||@C||@S||@K~|@Iz|@C~|@Mz|@gAz|@kG`|@gGh|@gGf|@}@x|@Nr|@Hx|@~Br|@hPny@~Stw@~Pdv@rOfz@lOzy@`Jj{@H||@?z|@Kz|@Ez|@Eb}@Cx|@Ib}@g@t|@Gz|@E||@Xz|@fH~{@zG~{@vGb|@`Cr|@i@x|@k@~|@e@||@]~|@yEb|@qKb{@cH|{@@||@C||@k@z|@X||@y@x|@mLvz@{O|y@yOry@wL|z@cAh|@J`}@J`}@Fz|@Jx|@N||@_@||@}Bp|@mAx|@_Az|@fBx|@L~|@Bp|@Pbz@@z|@@||@Nz|@t@z|@R~|@Bz|@D||@@v|@Bxy@Bdz@Drz@Jj{@Ul~@Ff|@}Irq@lg@Mca@pG|C|t@Dd}@Fh}@Uf}@gFt|@gIl|@_Fp|@tC`}@tCb}@tCb}@xBd}@Th}@Wf}@Kj}@Lj}@Bh}@Hh}@Fh}@pDx|@fJ~{@fDn|@qCd}@wC~{@uBts@}Bdu@`Ehm@b`@~_@pYja@v@bt@\\xy@kAbx@yDrm@Dlk@Ffn@Fdv@Hdj@uAht@M`|@jLjz@fWhv@~Vdv@|Svn@`Xtq@fXze@Prv@L||@Tj}@Nx|@Rd}@Fl}@St{@Dx}@nCz|@zI`|@pJt{@hKt{@~Iz{@pJr{@~Ilx@tJb{@nJ|{@vJt{@pKr{@lJz{@xI~{@pJv{@tJ|{@rJv{@`Odz@vVbw@~Vxv@~Vxv@~Vxv@|Vzv@~Vvv@|Vxv@|Vvv@~Vzv@jVbw@|Wfv@|Vzv@zVnv@~Vzv@zVtv@~Vbw@jUjw@`Gv{@mHdz@{Edy@gBfz@d@jw@r@~y@nEns@lPts@nQdw@rFtx@}Lf{@qTft@_Qfr@uN`y@yZjx@sRp{@nF|_AlDl`AmD|_A]r`Ar@r`Ah@p`A`Aj`A|@p`Az@p`Ab@h_AmK|~@gLx~@cL~~@jGn~@zY~o@r_@dn@l_@po@|_@vp@ba@~r@pa@bs@l`@~s@tO~|@nB`z@X|z@wIjx@Zzw@b@zx@Sbq@n^xYzo@g@|s@oCnt@sBhp@dL`c@hc@vd@`e@te@bf@de@re@rf@fg@hg@xg@th@fi@~g@ph@pe@xe@ve@ff@ng@~g@jg@|g@xd@je@nf@zf@pg@lh@lg@|g@lg@zg@xe@vl@ff@to@jd@vl@fd@|l@jd@vl@fd@xl@jd@xl@fd@tl@dd@pl@xa@pi@lb@dj@p_@fg@r`@zg@xa@xh@td@ti@bd@rh@zb@rg@na@~e@v_@~c@je@ld@~d@bi@fGl|@D`}@Jt}@Lr}@Dr}@_Cb}@qC`{@qC`{@mCl}@uCj}@uCn}@{Ch}@uCh}@mC`z@eCjy@yCr|@wCn}@uCj}@uCh}@}An}@oA|z@cBjn@}Bde@dAbp@gAxx@eA~_AmAf~@gAx~@Uj~@O|v@\\ly@bA`{@bAp|@x@pu@r@vp@x@ns@Tdr@B|x@hAnu@hH`t@`Jlv@vHbu@rHbt@jInw@tFj{@bDj|@hDtz@bDby@jDn{@`Dt|@jDlz@dDd|@hDb}@vDh`A|Aj~@Inz@xTht@vVft@|Pzw@fHp{@jH~{@bKj~@nJx|@hHxz@bHny@`G`y@^nv@jIdv@bRlr@xQbr@pIps@uNzk@yMrr@zLhl@`Ljk@hFxm@pMbk@`Ojo@lRfn@nSlq@~Klt@`L|t@pLxv@zFnx@Zpw@d@fx@Fft@eBjw@cAhw@~Bpw@|A|o@oK`|@aHnq@Rls@w@~q@cGzp@mGns@oGdv@Kzu@jHvk@|Lhh@Bfl@Lbl@~A|n@lNfg@`Mjh@dDjm@xWv`@bl@jQpb@j[fa@`\\nj@pa@ra@v^bD~u@bAbi@hBtj@pAnk@r@|l@p@pn@^nm@lFpq@jA|o@wEtr@t@`x@`Ptl@`Fxv@Bjl@xA`m@pYpa@~[x_@p\\d`@l]la@l]na@t\\l`@d\\b`@p]~Z~^zWv\\l^~\\|^z\\j^zZf]z\\j_@|Yx[j[p]t_@jb@x_@zb@l]na@t_@ra@bYta@dOr[oO|]zHbq@`Grg@pGfj@lIjp@~Z~{@qS`Vqi@t@}e@|Egg@Rii@Nyo@uKa_@sW}c@iMsm@Dsm@f@g}@Zws@\\_n@T}g@T{h@Ryj@o@wm@Fsq@\\su@hAaj@Dsi@Fgg@sFwk@jEek@bA_Kp_@Bhj@Lji@Hlm@Dlt@Lvv@Ynu@Ixw@N|w@Q`z@Wzy@@dz@D`z@]dz@R|y@G`z@Y|y@Tzy@dInw@`b@pi@rCfy@Ldz@P|y@I|y@K`z@B~y@B~y@B~y@D`z@D~y@D`z@qCpy@qEly@H~y@Fhz@Jbz@wJzv@yIxv@xFpz@nLbx@`Mzw@dMtw@rLzw@fL~w@Sfy@iFpy@}Ejy@iDvy@kH|x@eFjy@]zy@x@~y@jAvy@fKbx@j_@|l@fQxu@fDnd@fIkXcMpIjR~l@dM`t@sFz|@sOj{@`Gh}@fIxz@rHxv@fIny@pFt}@lFn}@lFp}@lFn}@lFv}@fGj}@lKl|@jKp|@pKl|@pKn|@jKp|@vKr}@~Kd_A|Kx~@`Ld_A~K~~@xKf~@tKf|@bK|z@nKt|@tKh}@`Ix_A~Dv{@xF~{@bHr{@jH|_AzIl_AnP~z@p[tl@lQ~w@nXlu@hZvo@hAp{@kFd{@M~~@Lx`ALv`ADn`ALx`AVz`AbCh`A~Bt`A`Cp`A|Bp`A~Bn`A`Cp`AbCr`ALl`AyGz_AmGd{@_Ezx@Nv~@Hx`ALv`AhAt`AtCr`AtCv`A|Cj`ArCv`ApCp`AwK`~@oVnz@mOvp@Fjq@Zxr@h@xy@zDr}@bHly@zHh~@pGp`AtBh`AzBt`AvBp`AyBl`AaFd`A_Cp`A_@x`A_@t`AwG`_AaItz@eJr_AqGf~@g@vz@v@n}@r@p_Av@r`An@z`Aj@x`At@h_AFz`AYv`AxFr_AhNj~@|D|_AUbaAQr`AS|`ASn`AMz`AQ`aAfAn`AnSf|@jTf|@`Zdy@vZlx@zY`v@pP~w@bDb~@`Dz|@bDh`AnDt`AjDv|@fDt`AlDj`AnDl`AjFb`ArH|_AnGr_AlEv|@tEj~@~Ef`ArFd`AdHr}@jHjaAfHx_AA~~@yB`}@uBf|@yBr}@sB|~@yBh`AcCp`AaBz`AaA|`AxDh`AlIn_AbIn~@xHn|@oA|y@aClv@eCpw@_C|v@cCfw@{@~v@nLdu@tOz|@bPb~@dPl}@vO`~@~On}@`P`~@|On}@rOx}@jQb}@dQf}@`Qr}@`Phy@|GdjALpw@Nb|@NfaAhB~aA`Nh`AbNh`A~Mb_A~Lb}@nMr}@rMr~@hCt`AD|_A?haADf}@@``AlNb{@da@pp@lb@pr@fa@pq@r]tt@p\\lv@j_@~u@bb@lq@dk@jg@r[rt@bRxy@lRtz@rRlz@hRnz@bOn|@hOv|@zQr|@~Try@`Uly@pUxy@hU|y@`Upy@hUjz@bUry@~Tby@dSju@vRly@|R~y@|R|x@fR~w@rSr{@lStz@pQhx@zQhy@bQxv@~Ovw@`Nhx@tNry@pNby@dQdx@bQns@hOpr@fNdt@hPvu@lP~u@dNtn@jKhi@gUra@g_@hc@q[n^oT|i@^fd@nS`g@jVzl@|Xll@bQhm@l@ht@tCfs@Ifk@Wjl@fc@|QlXr[oJiTif@}RaQr]vD~i@vTzh@dNpd@mb@fUkL~f@{\\lTog@tB{j@`Amq@G_n@`I}_@hg@g[~j@eBdu@i]ff@wg@dKcj@tGwi@hPwn@tLuo@jOoe@rc@ad@|e@m_@nj@o[vk@ki@|Xaj@`Sgm@zL}o@vMgq@nN_p@hFql@xFsi@rL{f@~IoGcc@_eBztAwj@pSyg@|Zei@zYyo@zP}j@f[in@bRsj@|Z}i@v[gi@`[oj@n\\ai@~[qi@z[}e@p^gc@zg@cd@bh@cf@dj@ue@|i@{e@`j@{e@lj@ed@li@sc@vk@ea@`o@w`@bo@}`@po@sg@ff@et@tJau@hCyt@zCgm@~\\oe@pj@ua@lg@_j@pa@sm@v`@}p@zRas@hVam@be@_j@tj@kj@lj@}m@tb@kr@b\\{n@|a@sX|x@iVvy@m^tv@sf@rn@}i@lj@qj@pf@{f@zl@sn@|`@ct@bV_s@nYc]|t@}V~z@kWjz@m]hu@gf@po@oe@ln@ed@|m@mb@bo@oc@fi@}o@x\\qd@no@a]fv@{\\vu@u]dw@{Kly@aAdp@mB~o@sSfv@e^xp@ca@xl@Br_A{Fz~@}A`bAeAd`AeC`aAaAb`AgN~}@}Xbv@cj@|i@kb@hm@sSjv@c]|n@yg@vb@e^br@oL`_Aed@zq@o[pu@c`@dt@q^dt@qu@lLqs@nV}s@rVii@nh@qT|{@gT|{@cTf|@mTn{@{Q~|@_Kn_AcKl`AgMrbAuRdbAuRhaAmRnaAkRxaAoR`aAw]r{@g_@b{@}^b{@wb@bw@kj@zp@}i@pp@sc@vv@s_@jz@{^nz@{[h}@}Zr}@}Zp}@g_@hz@ej@hq@gb@pw@k]|{@o]d|@q_@pz@ye@pu@qe@ju@{j@ho@is@fb@ys@|b@ss@dc@ct@~`@{w@rYms@zb@_s@fd@ir@ld@sm@hl@kc@|u@wHtdAoHleAy^rx@mn@hk@oj@zo@yX|}@mRpaAcW|_Asn@ti@it@db@{s@jb@_y@fVkx@nYav@z]}b@pw@{^~z@_b@rx@oe@xu@cXh~@iO~bAiO|bAwOxbAoOzbAoO~bAuGbdA~NzbAhOhcAlIfdApIjdAf[x|@tc@vv@bd@nw@xTr~@iKfdA}HjdA|M~bAhQ`aAvPrbAeBndAsGddAzSfaAxXx~@xX|~@tKbcAbDvdAdEdeAnRxaApSpaAxSlaA~S~`AlRp}@zSbaAhRpaAlPpbAdRjbAnShaApS|`A`PbcAMfeAwEddAyFbeAkPhbAcQnbA_QhbAuX`_Ay\\b|@{\\t|@k]n|@_]d|@s[t|@sXp~@uXd_AqXb_AsX`_A_Yl~@a]z|@{]j~@}\\n|@{\\p|@y\\t|@m\\r{@}\\p|@{\\n|@yXv~@wT`aAsT~`AqT`aAkTdaAyT|`AoLxcAmIpdAqIndAmIrdAyGxdAkE`eAyEheAkEbeAoEfeAgCpcAqFbeAgVz_AiYp~@iX|}@cCdeA_JldAe]h|@i^j{@m^t{@a^`|@cW|r@cIxq@eKr{@iJdbAwFvdAdCnfAtCxfAzCzfA~@fgA_OddAaXx`AaX`aA{Wz`A_Xp`A{WbaAoWlaA_UnbAaUfbAcUjbAmS~}@oQvaAeNxdAcN|dA_NvdAsNxdAsP|cAyPddAqPddAcPfdAkOldAoOndAmOpdAgOpdAmOndAmOndAcOlcAiNpbAkLxz@{K|w@iHvz@fCx|@nJpx@fI|r@`Cjw@l@dy@`Nb_AtQd{@zOr}@pGveAvGffA`HdfAjSdcAbV|aApVjbAtU|aAtGpfAiH~eAqKpeAkKreAkRncA}QvcAsBxfAMbgAQbgAUzfAgIhfAqKneAqKreAkK|dAmKjeAuKzeA_NvdAq_@t{@ig@zt@ms@|d@cP~aAuFzfAqHlfA}ElgAw@bhAgOldA}KheAnDtfAo@zfAeLneA_LreAkLleAgLneAiTnaAFbfAbPvcA|c@dy@t\\d}@jItdAjg@vu@jZt_ApPbdArPddA`F|eAiQxcAeW|`Aqh@zs@ki@zs@_b@bz@_J`fAyI~eAwI|eA_J`fAeU|aAeZ|_AcZ|_AeZz_Ac\\n~@kb@hz@mp@|h@iv@~`@io@|j@__@x|@}^z|@ma@xz@it@bd@cd@tw@k[f_Ae[j_Am[h_Aw\\n~@ya@zz@ua@b{@qa@zz@ya@`{@}W`aA}TpbAeVlaAuSjcA_UrbA}TlbAkGxeAjAhgAXfgAkDbgAiDxfAs@tgA~@jgA~@dgA|@hgApLtdAdYn`ArF~eAOfgAyQzbAyWraAsN|dAeFlfAWfgAvFvfAtGhfAzIdfAtIbfAxI`fAxIdfA|I`fA|KreAd[j_An[l_A`U~aApKxeAtKreAvIveAvFfgAxFjfAfCvfAw@fgAo@bgAeIneA}Xz`AwXv`AeQrcAaHlfA}GnfAyGhfA{GheAcHbgAyM`eAoO|dAiOrdAgB`gAm@fgAu@hgAu@bgAs@fgAw@hgAm@fgAq@fgAs@fgAs@fgAq@hgAeHraAa]zx@u]jz@mW`}@CftAvDjw@~Svq@wF`k@aXrg@a_@|o@ga@js@ca@`s@aa@ns@{`@js@}`@ps@ea@ds@ea@~r@ma@`s@ga@ds@ia@bs@ea@bs@o_@|t@g]fv@q\\du@}Ybp@yY`p@wY~o@wY~o@m[zo@k_@tt@s_@`u@e^dv@wXzy@ka@hs@uc@rq@qc@nq@}a@~r@qa@ps@ka@rs@qa@ts@ma@js@i_@fp@a[xi@g\\tk@o[lj@{[~j@s^xo@_d@|v@wa@~s@ue@ro@go@xb@eo@zb@go@|b@go@~b@eo@|b@eo@~b@eo@~b@go@|b@co@`c@io@~b@co@~b@eo@~b@go@`c@eo@~b@eo@bc@oo@|b@_o@bc@im@|e@yh@tl@wh@rl@wh@rl@uh@rl@wh@tl@wh@pl@uh@tl@{h@tl@sk@`h@au@jTmu@zSgu@vS_s@lVwh@fe@yi@~f@aj@hg@eh@le@kd@~a@wd@fb@y\\vZkc@~Rgl@dTor@~Vul@fT}k@jTyj@hSch@jRgn@hUyo@lXqn@t[{h@|c@gd@ni@ol@``@ml@``@kl@b`@ol@b`@ml@b`@kl@b`@ml@b`@ol@d`@kl@b`@kl@b`@ol@b`@kl@b`@kl@f`@mk@l_@ue@d[wk@v_@ml@h`@ol@f`@ol@f`@kl@b`@il@f`@{c@vf@gOnv@sOnw@oPdz@mPfz@oPdz@oPdz@oPfz@yMlq@uMpp@uOtw@oPfz@mPbz@gO~u@sOnw@oNpp@u\\dh@ke@x_@kg@xa@cf@v`@ud@l_@oe@``@mf@`a@ci@jc@uh@`c@ch@hb@uh@|b@ej@fd@ue@f`@kd@j_@gf@z`@ee@~_@{e@t`@ab@j]oc@h^{`@h\\s]lYea@n\\gd@d_@{a@b]ic@n^{i@f^gm@|^gm@~^am@z^cm@z^em@|^_m@`_@em@v^cm@z^gm@|^am@z^em@~^gm@z^{l@|^cm@`_@em@~^em@z^cm@~^_m@z^cm@`_@em@~^cm@`_@cm@v^cf@vd@af@pg@mg@|h@yf@tg@un@lUor@xGiq@tGim@|Fal@xFek@vFak@tFek@rF}j@vFck@rFok@rCsk@Tsk@Tuk@Rwk@Vuk@T_k@Tal@Tak@mFej@aLij@_Lij@aL}h@kKik@tFmi@rJal@jKgi@tJua@hDcd@dVk_@|Xu_@|[aa@|Tgg@w@ci@o@s]|[}Ylb@yi@bR_t@?wl@Dgd@bVwa@n`@e_@tf@q]rd@__@lf@s_@hg@m_@`g@i`@bh@g`@`h@{_@ng@u]zd@a\\xb@{^hf@}_@vg@q_@dg@k]nd@q\\jc@u\\tc@i]rk@vu@jw@pt@bc@rc@xW``@jUz^nTba@`Vfb@~Vhe@rYtj@xZ|n@`Wvo@nWtp@zWvp@~W`o@dV|n@|Vlp@vW~n@~V|n@~Vdo@`Wpp@xWvp@xW~p@zWxo@lWhp@tXzf@`j@dd@bn@fd@|m@nc@bm@xd@tn@j`@nk@fLpq@g@vq@{g@|c@c_@db@sEpo@aVhw@Hnp@h\\ln@dAzs@{Fva@`_@yL|N`b@vYbu@lLmO{OnJkVin@qKik@u`@x[tPwg@iHsb@kM_u@}B}i@eKyh@|[_u@bFql@je@yVb`@qm@uFeo@uOsm@k`@oi@id@_n@}c@sm@ed@}m@cd@ym@yg@mh@_q@cXmq@aX}p@aXcq@cXcq@aXaq@aX_q@{Waq@aXyo@mWwl@yU_m@cUwl@}Uwl@{Uwl@{Uwl@wUyj@cZ_j@c\\_f@oYkc@sWwa@oVe^cTmUrK}b@tCmg@I}u@Qi]b\\Ops@iVt[}}@Oc[t[Sn_Ae]t_@{XzZ}Uz^sWv`@u\\hc@o\\fc@o\\hc@o\\fc@e\\la@yi@dK{m@xKkm@zJoh@pI_Sbi@uOnx@oP`{@kPzz@sY`u@am@n^_j@db@s[tt@}h@ve@mr@xNst@iCuq@jPym@r]wn@~]cn@f]{m@f]gs@~Jot@c@kt@oCcp@iXco@gZoo@mZ{n@wZyp@eWqp@yVgt@aCut@Eut@Xqt@\\qt@Xqt@Dst@Cst@Est@Eqt@Ast@Mqt@Ako@Osl@Ckj@A}h@@ci@Hgg@?eMnk@Hbv@F~s@Bhl@e\\jOkf@Ake@Bac@Dcc@Bsl@Aun@Ga@lo@@dk@E|q@C~q@Gzq@Kbr@O|q@Ilr@?|r@Apt@Efx@Gvy@Cxy@Fty@Dty@Bvy@Czy@Cry@Aty@Cty@lGdx@hc@ne@vd@nc@rIrw@h@zy@h@ty@Vty@`@vy@`@ty@?ry@Ivy@?ty@~Ptq@vf@za@pa@n]hKxz@mHnw@gLps@gUrt@mU|t@eU~t@eU`u@gU~t@gUzt@iU`u@wNxw@{Hvy@z@xz@fDtz@v@vz@uQpv@qUxt@gAxy@`Fpz@eFhz@wH|y@gRvu@k`@dl@qMzx@eKhy@Yzz@eFhz@sDbx@{F~t@qNxp@Cdt@qHvr@yXtj@{Djt@sBnt@qBdt@cRnm@a_@xd@eI~q@u@jt@~Dzs@rFns@tHhs@lPhp@|Gbr@mO`p@}R~n@sStp@oMjq@mEzs@oE|s@r[nd@xSvg@cTtm@uTzg@uJdh@_Qvh@Bjo@tFjr@{C`r@sJnr@s^lc@gc@b_@ik@jC_k@kAca@qVsXrRuK|m@}Crm@eFdm@mSxn@aRxo@}Sdm@o\\dg@uRnn@W|s@pX~h@v[vf@z[lf@bl@zCpk@rEpj@yC~]|\\yCtq@oHzd@_Ezf@qMtf@aV~^aG|m@Ihi@gFlk@|Hni@v@xm@dHji@fFfi@jCzj@q@lk@lNbh@jNne@vTva@|D~k@vPnf@z_@tTdb@pOpp@hLkAvd@gUhd@qXpc@uYf[kVj`@yLlf@Qfm@{F~m@o@rp@cMvn@eA~p@kHto@qRpi@gTzk@iVth@wOhl@qSpi@e_@l]gPtl@}Lvm@oSbk@mRhl@w_@l]kMzl@sNzj@uMtk@kGvk@iMpm@wIxl@gDtl@hBtj@`U|b@jSb`@hd@rW_Sx]e]hM|Cnj@gP`h@tSdU|QpYyKbb@mFzq@gb@ZK~i@qi@O]hVxq@dVhKhy@dJdw@yCfu@kGdp@{G`s@dVht@ra@ho@ja@pl@~A|y@yEffAfN~w@Zzn@uDrs@uDv}@c^lw@~@nu@aCty@iKng@kXd_@fAfn@nBlq@vBjk@bM`l@~^pb@v\\`a@l`@~b@z`@~Kti@eJjj@J~h@Dvj@Bbi@Bbi@Bnh@Dzk@oDdf@aWvY~p@rOpg@vP|j@tQzm@hPpj@pQ~m@tRto@dS|q@xSrr@rSjr@xTft@bT|s@~Spr@hVln@lWjo@~Whp@dYnr@xX~q@rXxq@jYrr@|Xfr@rXjq@hZpt@hYvr@nY~r@|V|m@q{E~gPp`@jJp_@cQxVca@fTyf@zQ}k@qEgm@mP{x@tLoaA|@qi@fOye@vPeg@|Kwj@tS{n@dY_`@oFkd@yW_p@sXqq@sXoq@sXmq@oXmq@sXqq@sXmq@sXqq@qXqq@sXoq@sXqq@eWwq@}Tun@mRuo@_Tis@kTct@cTws@sT{t@cTus@_S}p@qP{j@{Ogi@qPqi@}Nye@gOie@wW}n@ia@iYoa@Zi_@xQoVdj@{i@Cig@Ewk@Eml@Ail@@qh@fKka@_Qkf@Jwi@hPaj@nP}i@jP{i@pP}i@lP_j@lPeh@vOqg@nO}i@nP}i@jP_j@nP_j@lP}i@lP}i@lP}i@pPai@bPid@dHah@x@il@|[qc@~Tyd@rVue@dVg]dc@y`@z\\wj@oC{o@zFap@dGep@bGcp@bGcp@zF_p@zFcp@bGgp@bGap@bGcp@bGcp@zFcp@bGcp@dG_p@fGcp@bGcp@`Gcp@dGcp@dGep@`Gap@fGep@bGap@dGep@fGqo@bKmo@hKmo@hKko@hLuo@dJqo@jKyo@p@}o@yIuo@sIqo@uIwo@sIwo@uIwo@uIyo@sIap@{Fep@cFep@cFgp@eFep@gFgp@eFgp@eFwo@sHin@cPqn@_Psn@_Pqn@{Okn@}Okl@oVag@ab@}e@ac@af@{c@ye@uc@{e@sc@ye@sc@{e@uc@cf@cd@u`@yj@k]wm@k]ym@m]{m@i]wm@qZoi@oXef@iXud@qY}c@i[qe@k_@al@{a@so@o]uk@}Vkd@mYih@_Zgi@mZwk@a\\mWsU}[wYre@uZlg@g^xl@k^~l@i^fm@ee@ld@kg@ja@gg@xa@oc@lg@sb@fh@ub@fh@qc@xf@if@hc@ie@xc@aj@z\\yd@vZyMjo@qFlv@hGv{@mB|w@sd@zi@}Ip|@tBdaAw@dt@}@l~@}@b`A_An~@oBv}@kOnz@yOdz@qOdy@aUvw@mVvs@}N|u@__@pr@{c@jp@oe@vn@ee@hn@{b@~p@{Vdv@bOxu@}Lht@aU`x@{Rrz@qQdy@cJ~z@sN|z@gO`}@g[fs@wh@hf@wg@pe@yh@lf@oi@dg@cj@xg@uj@hh@}i@rg@yh@tg@o[tv@gWp{@kV`|@_Rf{@xAfbAfEfcAbExbA`EhbAfE`cA|H~bAhI`bAjI|aAhIbbAjE`cAlDxbAdDzbAU`cAeBbcAcBdcAcB~bAeB~bAcB~bAaB`cAeBbcAaB`cAeB`cAaBbcA_B~bAcBbcAcB`cA_BbcAuAb{@_B``A_B`aA_BjaAqAr|@eBr`AyAn_AeCr|@eLhx@eGb{@_Xtx@aX~v@sXfx@oSjy@gLn{@qJp{@Xtz@cQx{@_Qr{@cO|u@qAxo@lBpm@|Bxw@l@br@yj@lIwx@hK_z@zKaz@|Kez@zKgz@fLez@jK}z@jHkz@dH_{@fAa{@yB}w@iHqo@yMa^oE}i@tPa_@pJfQ|t@|d@xb@b`@tUta@pVrc@xW~g@xTz\\`l@l[jp@n\\br@xNvx@Kf{@Wd|@qDh}@qStv@wc@dl@a`@zq@tI~x@fFlu@Kvs@ce@x_@yq@p[}r@h\\ks@l\\so@|e@}i@td@sk@bf@gm@pg@ck@ne@el@vf@}i@|k@e]hz@a\\~w@}\\fy@u[~v@gZdt@s[zv@o\\nx@y\\fy@oUbz@bBj|@t\\np@~Xxp@hThz@rTvz@pRpu@fSzv@nMtf@jPzn@`Rps@xOrx@pJxy@tJ`z@fK~|@vKf_AxKj_AlKv}@jK|}@jK||@rKl~@|Jl{@dKb|@bK`|@tJxy@`Kr{@pKb~@rK`~@Cn}@mIv|@kId|@eIp{@kIp|@}Hnz@sHlx@sHdx@sHvx@qHfx@}H~y@uHby@uHvx@sHnx@gHnv@xDng@~f@rQrc@bPpe@~Ple@|Pbj@bSeDhn@aSng@c[ty@}Dfs@~Fex@vZow@`V_}@{Ycc@is@oWgb@mOc`@mNyb@wOu[`LyGxs@qHbx@wHxy@yHvy@yHty@yHty@wHvy@{Hty@wHry@wHvy@wHxy@yHry@wHxy@uHty@yHty@wHxy@uHry@uHvy@wHty@uHvy@uHty@uHty@uHty@wHzy@iHlw@kGzq@kI~o@wRnb@{Xlc@cWh\\y]hQk]hSoe@`Xm[rg@eVvn@iYrl@{Svo@w`@~_@od@`_@aa@td@u]jh@k]lg@ab@x\\uj@zNef@h\\sj@hQuh@vNsc@zQ}Xlc@uYjd@cLtj@eNzn@yQlx@_O|v@gGpy@wPzv@uNfv@M~y@wAly@gHvcAk[dw@eQpw@}Kry@iLny@kJ~y@iK`z@gMfy@wMtw@sK|n@eJvi@oO|l@iQrn@aNpr@eEj|@wCx{@}Cb}@oCv{@k@x{@zMfy@pNzx@vAb|@wFl{@uFh{@wFn{@wFb{@wFh{@uFz{@wF`{@sE|r@mExq@qEzq@kExq@mEzq@oEzq@qE`r@mEvq@gEbr@oAlr@bAjr@vEzq@dJnp@lNzp@pOnt@x@pq@{Qfm@_Srl@{Rpl@}Rhl@sPdn@{M|n@eNho@{Spj@c\\hl@mGjr@zFrt@xFvq@tGhw@vG~w@zGxx@|Gxy@`Rfu@xe@le@ve@`e@le@fe@xb@tg@vYvp@fP~w@bOfx@`Odx@jOtx@jO~x@tO|y@nOdx@lOrx@dOrx@lOnx@hOhx@jObx@bO`x@jOfx@`Ohw@hOxx@jOjx@fOdx@dO~w@bOhw@vQpw@tSxu@xSvu@xSru@rShu@`Tdv@|Spu@xSpu@xSlu@~Rjv@|L~x@pL~x@`Lbx@`Mby@~Lvx@pRtq@hU`u@~T~t@pT`u@pTfu@`Ilz@pEh{@~Erz@~Etz@|Fnz@xO~w@`Xrr@pa@|l@j`@hl@tBzz@lNhx@dHl|@xEp{@nEdy@lFf{@vFl{@tF||@zEf{@hFdz@jFb|@`Frz@xEbz@zEzx@xFvy@`Frz@bFtz@tE`{@pAb{@~\\jp@hc@vl@hNvw@i@pw@[dk@[ji@Edw@_Arp@gChKgQnMog@jWac@pTkg@jWii@va@ag@fe@c_@bb@mm@pGot@bLyu@nTit@fZqs@jZor@lYso@hX}n@~W{m@fWen@lWem@vV}m@jWei@zTub@rQyi@dUol@jV}j@hQkp@nMer@lOym@bUqp@jFcn@oVal@s[ao@zEcd@rd@yc@nj@oc@bj@wi@r_@mr@zLsq@tLgp@rGer@W}q@fBcr@mBup@Amp@_@ol@qTsh@sa@ii@cb@kh@ka@qi@y`@ye@}]aX_h@i`@mUs^}i@ya@wDmBlo@^hcA\\`q@\\br@\\|r@Flu@sFvy@cFnu@kGzq@yIbn@ie@~Usi@vX{g@zYsb@nd@_^xm@w]nn@e^|l@s`@ph@qZpq@{a@hi@cTjv@wRbv@qb@ph@}b@`i@ePtv@`Gry@zGzy@iBrz@iKxx@sKxx@uKzx@oKrx@mKvw@_Onx@yYdq@kc@lg@ee@vd@u^|l@e^lm@g^nm@{]bm@s]nl@c_@xm@ib@th@we@ld@cf@hd@{e@bd@oe@vc@cf@fd@{d@hc@ef@ld@oe@xc@qe@xc@ye@dd@uf@be@qf@ne@se@pd@oe@nd@oe@pd@ee@dd@}e@~d@oe@ld@oe@rd@s`@xj@cV|r@{M`y@_M|x@aMrx@}Lnx@aMpx@wLjx@}Qzu@a]tn@yd@he@af@tc@gf@|c@cf@vc@ef@zc@cf@xc@{d@te@m\\zn@sQfv@mMnx@mMfx@iM|w@mNnx@kNhx@iNjx@iN~w@kNdx@iNdx@gN~w@iN~w@uMnx@eLxx@gLzx@qIhy@`Jvx@qGtz@{H|y@yHvy@kIxx@iJtr@mV|Rkn@_Hgg@cBko@{Ywn@io@om@}m@yXu`@~Wba@j[t[vZ`[p[t[th@~a@azB{sBd^j^n\\z\\r^z^|VbS_Nci@cYom@cc@mg@al@}[gq@qToh@ag@sf@yl@mh@}n@wh@wo@qb@ov@{Vuz@{M}aA}J{cAcKwcAkKucAeKwcA}JwcAeK_dAuHydAZ_eAx@keAoDaeAyE{dAiGsdAgK{cAqK_dAiKucAuKicAsPebA}V}~@a]a{@}`@kw@m\\}p@g[gp@}Zwo@{Zwo@e[cp@{Zqo@}Z}o@}Zuo@iVyp@{]bJcTiP_]wQ}@xc@ca@_Lg^f`@gCza@xHxp@jYaf@nm@iSzUla@p\\|m@hw@vEhd@cWpr@{Hbl@^nc@b@zb@`@`c@`@|d@b@di@aF~a@cHvc@y@nh@}Eji@sSph@rM|e@cH@\\`b@ka@r_@cz@fO{k@p^tUfo@jZ~|@fS``@qPoAw`A}Uor@_g@s\\aZiUePpK|YxZp_@z@nk@zZtCht@r@x`A`k@jCnc@hBn_@jLj^dUpd@vUSp]v_@vTTzTpEyd@|a@iY|a@uJtc@oFvb@yGhl@`Zl^|Rn`@|W`c@rZh[xm@h[df@|Ovo@nY`m@dLj_A`Qje@|Xtu@WhIkPir@lPzm@zWpl@hRle@fb@`f@la@vh@~^dVeS~k@m^bj@yf@fe@ei@tf@kj@vg@sj@xg@_j@ng@qi@rh@s^hm@sSdt@yMnz@eNl{@}Mtz@{Nlz@mOv{@kOf|@_Ozz@eOb{@yOf}@qOz|@uOt|@eNz~@kMn}@gMj~@`Gx|@}Brx@iId|@gI|{@oIr{@oKfx@wTxT}m@kHkk@qBk]eJfFzRhFr_AhOr_AvRf_AqEjcAaGbcA_GdcAkGhcA{Qn_Aq^nx@sc@zs@sc@ps@ek@ri@ga@tt@gXv|@qXp|@oXt|@EjbA\\vcAoGfcA{IvbAwIvbAsIzbA{IzbAsItbAwIxbAoIvbA{H|_AyCrcAiBzcAcB|cAaB|cA_BzcA{AjcAeB|_AuH|aAmPx`AwTv~@wTv~@wTt~@wTx~@sTx~@wTv~@_Uv~@wTt~@wHdbAiApcAuPp`AyPp`AyPr`AyTh~@mn@lc@cr@xZ}Ztx@ThdA|FhcAAxcA}JlbAmObaAeRb`AaRb`AaR|_AgRz_AaRb`A_R~_A{Qb`AoQh~@aR``AaRd`A_Rb`AcRd`AuRt_A{Tx~@cTb_AePv`AsJnbA}H|bA_IvbAwHbcAgHraAsAvy@uJbw@sFr^_Int@sKty@mKh~@iGfaAiF~cAgFfdAgFbdAaHrcAiIvcAoB~cAzF~bAgEjdAkEhdAgEfdAgF`dAeLpbAqTx_AoVt~@_V|}@sVh_AiVl~@iVt~@kVt~@cVv~@eV`~@gV~}@oMtaAlTr_AMfaA_Xf~@{Wx}@sW|}@yWz}@wWz}@yW|}@yWz}@{Wv}@wXd}@oXh}@qVd~@h@rdA~ApcAaApdAaAvdA_AzcArDfdAmJpcAaK`~@sGr_AsKz`AqN~aAqNfbAuMtaA{KdcAc@|dA~J|bAjVz{@|Yzj@lb@zm@`f@hr@ld@ps@p]fz@di@hl@lc@xn@pId_AyRz_AsV`y@qLb}@wKj}@wPbaA_Sz~@cSb`AqWj}@mSh~@cOzbAk[dz@ak@jk@oWp}@od@vs@}\\lz@q[l{@s[r{@m[l{@mZd|@gPnaAaCndAbH~cApChdAsVr}@uJ~bAcNfcAkJrbAlKb`AxNzbAfOzaAnL~bAs@tdAoPx`AmRt_AiObcAeOjbAaO`bAeNt`AqBtbAxNpbAdW~z@r@jdAs@ndAVpeAVtdATndA}BndAaVb_AwIlcA`@~eAjOl~@pZvQl^yHCxHqHkr@e[cZql@tAwi@hCeg@eQ{l@dMgj@rF_l@f@kl@nAme@cQeo@mIkr@rMeq@zLun@k]sk@i^um@uTgq@sPir@yPep@~Huo@|Vmh@ta@um@l\\cg@sR_f@Luv@pHcy@jHiw@eAaz@zHox@~Sgz@nTcz@hBiu@re@at@`[mu@fKcs@eZey@qMmw@mTgw@sW{y@aVs{@eNc{@hDa|@hD{y@nD{v@p\\}x@fSc{@fHsy@dWuz@dLc{@zKi|@rLom@bk@yh@fv@yf@|r@uo@bg@_t@td@qs@vc@sw@|Uuv@hKgc@fLm`@tTe]`ZeTbe@kb@`Ccv@_Fg|@}Fq|@aGqy@mFcz@uJkv@u`@i{@vDg|@fD{{@_Dw}@tBsz@gDuu@k`@op@{Yeq@~@oa@qb@{\\q^k_@{Uuh@cDqc@qQsf@eOik@wP{a@m`@mX_o@eUkn@g^_i@s\\yf@qf@_Ewh@uC{e@wUib@{QcT_i@mi@pDw`@|VmV~Vr`@lBgYb`@s_@~QuYlh@eW``@e`@eV}]i[a]cZ}[}]{Yca@q_@qYw`@{PcZy_@eNgb@u[wXc]{_@o^qTkLy_@wBpOh[d\\ba@vUf[~ZdP|]~Xv]~Zx[j`@pShZl[zYz\\v]~Zb[x]b_@xZ`d@zPrSok@f]c`@r_@yZlBmXaW{Ov`@qVjg@eMza@tMv]j\\`^zXdg@lQvl@mHz`@x]xYzb@zZld@|P|i@nV~k@xa@p`@vh@zOfk@tPfi@hPnh@`Jlf@zY|Xjj@zl@|R|v@vEtl@fZdq@hZt{@wB~y@uBh{@fG`}@aIfz@fEzt@f]|y@vFnz@vFx{@vFr{@tFnr@rE~_@qPdVuf@x`@yTv`@sTjd@cFhu@{Lzw@g[jt@}d@hr@kc@tm@il@|g@yt@`i@av@dr@}^b|@oLf|@sLzz@aLvp@kVd|@eFzw@_Wtv@cYh|@aD`}@mD`{@aDdx@`Sfy@bU`x@xYzn@tO`f@t@lk@ba@ry@[|r@eXbt@}\\~s@yNbv@oLpx@}Svz@cQ`x@gBht@qAd{@sHvp@{Gd`@`One@h@be@kWph@eb@~n@sVjp@}Hpt@zQjp@lPvm@zTnm@l_@hp@rZrq@gOns@oJzl@jNzf@jJ`h@[`j@e@rf@kEng@yK`e@`I`i@dAnj@}And@zIzMxk@";

    function initMap() {
        var pleasant_ks =  {lat: 39.036680, lng: -98.384473};

        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 4,
            center: pleasant_ks,
            fullscreenControl: true,
            styles: [
                {
                    "featureType": "administrative",
                    "elementType": "all",
                    "stylers": [{"saturation": "-100"}]
                },
                {
                    "featureType": "administrative.province",
                    "elementType": "all",
                    "stylers": [{"visibility": "on"}]
                },
                {
                    "featureType": "landscape",
                    "elementType": "all",
                    "stylers": [{"saturation": -100}, {"lightness": 65}, {"visibility": "on"}]
                },
                {
                    "featureType": "poi",
                    "elementType": "all",
                    "stylers": [{"saturation": -100}, {"lightness": "50"}, {"visibility": "simplified"}]
                },
                {
                    "featureType": "road",
                    "elementType": "all",
                    "stylers": [{"saturation": "-100"}]
                },
                {
                    "featureType": "road.highway",
                    "elementType": "all",
                    "stylers": [{"visibility": "simplified"}]
                },
                {
                    "featureType": "road.arterial",
                    "elementType": "all",
                    "stylers": [{"lightness": "30"}]
                },
                {
                    "featureType": "road.local",
                    "elementType": "all",
                    "stylers": [{"lightness": "40"}]
                },
                {
                    "featureType": "transit",
                    "elementType": "all",
                    "stylers": [{"saturation": -100}, {"visibility": "simplified"}]
                },
                {
                    "featureType": "water",
                    "elementType": "geometry",
                    "stylers": [{"hue": "#ffff00"}, {"lightness": -25}, {"saturation": -97}]
                },
                {
                    "featureType": "water",
                    "elementType": "labels",
                    "stylers": [{"lightness": -25 },{"saturation": -100}]
                }
            ]
        });

        for (var i = 0; i < stops.length; i++) {
          var latLng = new google.maps.LatLng(stops[i].lat, stops[i].lon);
          var marker = new google.maps.Marker({
            position: latLng,
            map: map,
            title: stops[i].name
          });
        }

        var routePath = new google.maps.Polyline({
          path: google.maps.geometry.encoding.decodePath(encoded_route),
          geodesic: true,
          strokeColor: '#FF0000',
          strokeOpacity: 1.0,
          strokeWeight: 4
        });

        routePath.setMap(map);
        
    }
</script>
{% endraw %}
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCgUYlm-BQOCLSc66tIMVe3DUSXwxpAjDw&libraries=geometry&callback=initMap">
</script>
