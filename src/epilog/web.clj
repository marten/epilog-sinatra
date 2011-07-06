(ns epilog.web
  (:use ring.middleware.reload
        ring.middleware.stacktrace
        ring.adapter.jetty))

(defn handler [req]
  {:status 200
   :headers {"Content-Type" "text/plain"}
   :body "His from Clojure!\n"})

(def app
  (-> #'handler
      (wrap-reload '(epilog.web))
      (wrap-stacktrace)))

(defn -main []
  (let [port (Integer/parseInt (System/getenv "PORT"))]
    (run-jetty #'app {:port port})))
