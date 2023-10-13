import React, {useEffect, useRef} from 'react';
import {Box} from 'theme-ui';

const QAndAPage: React.FC = () => {
  const iframeRef = useRef<HTMLIFrameElement | null>(null);

  useEffect(() => {
    const sendAccessTokenToIframe = () => {
      if (iframeRef.current) {
        const iframeContentWindow = iframeRef.current.contentWindow;

        if (iframeContentWindow) {
          const accessToken = window.localStorage.getItem('accessToken');
          if (accessToken) {
            console.log(accessToken);
            setTimeout(() => {
              iframeContentWindow.postMessage({token: accessToken}, '*');
            }, 1000);
          }
        }
      }
    };

    sendAccessTokenToIframe();
  }, []);

  return (
    <Box
      sx={{
        flex: 1,
        overflow: 'hidden',
      }}
    >
      <iframe
        ref={iframeRef}
        src="http://localhost:8080/model_settings"
        width="100%"
        height="100%"
        title="Model Iframe"
      ></iframe>
    </Box>
  );
};

export default QAndAPage;
